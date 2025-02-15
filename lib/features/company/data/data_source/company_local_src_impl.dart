import 'package:clean_architecture_flutter/core/base_services/sqflite/transaction_table.dart';
import 'package:clean_architecture_flutter/features/company/data/data_source/company_local_src.dart';
import 'package:clean_architecture_flutter/features/company/domain/entities/company_transaction_summary.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/transaction_data_model.dart';

class CompanyLocalSrcImpl implements CompanyLocalSrc {
  final TransactionDB _transactionDB = TransactionDB();

  @override
  Future<List<CompanyTransactionSummary>> getDashboardData() async {
    var results = await Future.wait([
      _transactionDB.getCompanyTransactionSummary('A'),
      _transactionDB.getCompanyTransactionSummary('B'),
    ]);

    debugPrint('Inserted transaction IDs: ${results[0]}, ${results[1]}');
    CompanyTransactionSummary companyTransactionSummaryA =
        CompanyTransactionSummary.fromJson(results[0]);
    CompanyTransactionSummary companyTransactionSummaryB =
        CompanyTransactionSummary.fromJson(results[1]);

    return [companyTransactionSummaryA, companyTransactionSummaryB];
  }

  @override
  Future<List<TransactionModel>> getTransactionHistory() async {
    // List<TransactionModel> transactions =
    //     await _transactionDB.getAllTransactions();
    // for (var t in transactions) {
    //   debugPrint(
    //       'ID: ${t.id}, Company: ${t.companyName}, Savings: ${t.savingAmount} '
    //       'Withdraw: ${t.withdrawalAmount}');
    // }
    List<TransactionModel> transactions =
        await _transactionDB.getAllTransactions();
    return transactions;
  }

  @override
  Future<bool> saveDeposit(String amount) async {
    double splitEqualAmount = int.parse(amount) / 2;

    // Insert a transaction
    TransactionModel transaction = TransactionModel(
      companyName: '',
      savingAmount: splitEqualAmount,
      createdDate: DateTime.now(),
      updatedDate: DateTime.now(),
    );

    var companyA = transaction.copyWith(companyName: 'A');
    var companyB = transaction.copyWith(companyName: 'B');

    var results = await Future.wait([
      _transactionDB.insertTransactionWithTotalDeposit(companyA),
      _transactionDB.insertTransactionWithTotalDeposit(companyB),
    ]);

    debugPrint('Inserted transaction IDs: ${results[0]}, ${results[1]}');
    return true;
  }

  @override
  Future<bool> withdrawAmount(String amount, String companyName) async {
    TransactionModel transaction = TransactionModel(
      companyName: companyName,
      withdrawalAmount: double.parse(amount),
      isWithdraw: true,
      createdDate: DateTime.now(),
      updatedDate: DateTime.now(),
    );

    int insertedIdA =
        await _transactionDB.insertTransactionWithTotalDeposit(transaction);
    debugPrint('Inserted transaction ID $companyName: $insertedIdA');
    return true;
  }

  @override
  Future<bool> deleteTransactions() async {
    return await _transactionDB.deleteTransaction();
  }
}
