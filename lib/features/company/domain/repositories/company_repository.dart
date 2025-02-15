import 'package:clean_architecture_flutter/core/bloc/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/transaction_data_model.dart';

abstract class CompanyRepository {
  Future<Either<Failure, bool>> saveDeposit(String amount);

  Future<Either<Failure, bool>> withdrawAmount(
      String amount, String companyName);

  Future<Either<Failure, List<TransactionModel>>> getTransactionHistory();

  Future<Either<Failure, dynamic>> getDashboardData();
}
