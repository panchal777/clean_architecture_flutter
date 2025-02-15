// Using Raw SQL to Create the Table
import 'package:clean_architecture_flutter/core/base_services/sqflite/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../../features/company/domain/entities/transaction_data_model.dart';

class TransactionDB {
  static const tableName = 'transactions';
  static const id = 'id'; //Auto increment
  static const companyName = 'companyName';
  static const savingAmount = 'savingAmount';
  static const withdrawalAmount = 'withdrawalAmount';
  static const isWithdraw = 'isWithdraw';
  static const createdDate = 'createdDate';
  static const updatedDate = 'updatedDate';

  static const totalDeposited = 'totalDeposited';
  static const totalWithdrawn = 'totalWithdrawn';
  static const finalAmount = 'finalAmount';

  static String transactionTable = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $companyName TEXT NOT NULL,
      $savingAmount REAL NOT NULL DEFAULT 0.0,
      $withdrawalAmount REAL NOT NULL DEFAULT 0.0,
      $isWithdraw INTEGER NOT NULL DEFAULT 0,
      $createdDate TEXT NOT NULL,
      $updatedDate TEXT NOT NULL,
      $totalDeposited REAL NOT NULL DEFAULT 0.0,
      $totalWithdrawn REAL NOT NULL DEFAULT 0.0,
      $finalAmount REAL NOT NULL DEFAULT 0.0
    );
  ''';
  DatabaseHelper databaseHelper = DatabaseHelper();

  // Insert Transaction (without providing primaryId)
  Future<int> insertTransaction(TransactionModel transaction) async {
    final db = await databaseHelper.database;
    return await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertTransactionWithTotalDeposit(
      TransactionModel transaction) async {
    final db = await databaseHelper.database;

    // Fetch the latest transaction for the given company name
    final List<Map<String, dynamic>> result = await db.query(
      'transactions',
      where: '$companyName = ?',
      whereArgs: [transaction.companyName],
      orderBy: '$createdDate DESC',
      limit: 1,
    );

    // double previousTotalDeposited = 0.0;
    // double previousTotalWithdrawals = 0.0;
    double previousFinalAmount = 0.0;
    double checkBalance = transaction.isWithdraw
        ? transaction.withdrawalAmount
        : transaction.savingAmount;

    if (result.isNotEmpty) {
      // Extract the totalDeposited value from the latest record
      // previousTotalDeposited = result.first['totalDeposited'] ?? 0.0;
      // previousTotalWithdrawals = result.first['totalWithdrawn'] ?? 0.0;
      previousFinalAmount = result.first['finalAmount'] ?? 0.0;
      if (previousFinalAmount < checkBalance) {
        throw Exception('Insufficient Balance');
      }
    }

    // Update the totalDeposited field by adding the new savingAmount
    double currentFinalAmount = previousFinalAmount + transaction.savingAmount;
    double currentWithdrawal = transaction.withdrawalAmount;

    // Create a new TransactionModel with updated totalDeposited
    TransactionModel updatedTransaction = transaction.copyWith(
        totalDeposited: previousFinalAmount,
        finalAmount: currentFinalAmount - currentWithdrawal);

    // Insert the updated transaction into the database
    return await db.insert(
      'transactions',
      updatedTransaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve All Transactions
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('transactions', orderBy: '$updatedDate DESC');
    return maps.map((map) => TransactionModel.fromMap(map)).toList();
  }

  // Update a Transaction
  Future<int> updateTransaction(TransactionModel transaction) async {
    final db = await databaseHelper.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  // Delete a Transaction
  Future<int> deleteTransaction(int primaryId) async {
    final db = await databaseHelper.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [primaryId],
    );
  }

  Future<Map<String, dynamic>> getCompanyTransactionSummary(
      String companyName) async {
    final db = await databaseHelper.database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      COALESCE(SUM(savingAmount), 0) AS totalCredited,
      COALESCE(SUM(withdrawalAmount), 0) AS totalDebited
    FROM transactions
    WHERE companyName = ?
  ''', [companyName]);

    if (result.isNotEmpty) {
      return {
        'companyName': companyName,
        'totalCredited': result[0]['totalCredited'] as double,
        'totalDebited': result[0]['totalDebited'] as double,
        'finalBalance': (result[0]['totalCredited'] as double) -
            (result[0]['totalDebited'] as double),
      };
    } else {
      return {
        'companyName': companyName,
        'totalCredited': 0.0,
        'totalDebited': 0.0,
        'finalBalance': 0.0
      };
    }
  }

// Future<TransactionModel?> getLatestTransactionByCompany(
//     String companyName) async {
//   final db = await databaseHelper.database;
//   final String query = '''
//   SELECT * FROM transactions
//   WHERE companyName = ?
//   ORDER BY createdDate DESC
//   LIMIT 1;
// ''';
//
//   List<Map<String, dynamic>> result = await db.rawQuery(query, [companyName]);
//
//   return result.isNotEmpty
//       ? /*result.first*/ TransactionModel.fromMap(result.first)
//       : null; // Return the latest record or null
// }

/*
  Future<List<TransactionModel>> getCompanyWiseTransactionSummary() async {
    final db = await databaseHelper.database;

    String query = '''
    SELECT 
        t.id,
        t.companyName,
        t.savingAmount,
        t.withdrawalAmount,
        t.isWithdraw,
        t.createdDate,
        t.updatedDate,
        SUM(t.savingAmount) OVER(PARTITION BY t.companyName) AS totalDeposited,
        SUM(t.withdrawalAmount) OVER(PARTITION BY t.companyName) AS totalWithdrawn,
        (SUM(t.savingAmount) OVER(PARTITION BY t.companyName) - 
         SUM(t.withdrawalAmount) OVER(PARTITION BY t.companyName)) AS finalAmount
    FROM transactions t
    WHERE t.updatedDate = (SELECT MAX(updatedDate) 
                           FROM transactions 
                           WHERE companyName = t.companyName)
    ORDER BY t.updatedDate DESC;
  ''';

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return maps.map((map) => TransactionModel.fromMap(map)).toList();
  }
*/
}
