import 'package:clean_architecture_flutter/features/company/domain/entities/company_transaction_summary.dart';

import '../../domain/entities/transaction_data_model.dart';

abstract class CompanyLocalSrc {
  Future<bool> saveEntry(String amount);

  Future<bool> withdrawAmount(String amount, String companyName);

  Future<List<TransactionModel>> getTransactionHistory();

  Future<List<CompanyTransactionSummary>> getDashboardData();
}
