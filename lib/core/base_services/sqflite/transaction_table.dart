// Using Raw SQL to Create the Table
import 'package:clean_architecture_flutter/core/base_services/sqflite/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../../features/company/domain/entities/transaction_data_model.dart';

class TransactionDB {
  static const tableName = 'transactions';
  static const primaryId = 'id'; //Auto increment
  static const companyName = 'companyName';
  static const savingAmount = 'savingAmount';
  static const withdrawalAmount = 'withdrawalAmount';
  static const isWithdraw = 'isWithdraw';
  static const createdDate = 'createdDate';
  static const updatedDate = 'updatedDate';

  static String transactionTable = '''
      CREATE TABLE IF NOT EXISTS $tableName (
        $primaryId INTEGER PRIMARY KEY AUTOINCREMENT,
        $companyName TEXT NOT NULL,
        $savingAmount REAL NOT NULL DEFAULT 0.0,
        $withdrawalAmount REAL NOT NULL DEFAULT 0.0,
        $isWithdraw INTEGER NOT NULL DEFAULT 0,
        $createdDate TEXT NOT NULL,
        $updatedDate TEXT NOT NULL
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
}
