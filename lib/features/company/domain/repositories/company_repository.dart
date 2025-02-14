import 'package:clean_architecture_flutter/core/bloc/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CompanyRepository {
  Future<Either<Failure, dynamic>> saveEntry(String amount);
  Future<Either<Failure, dynamic>> withdrawAmount(String amount,String companyName);
  Future<Either<Failure, dynamic>> getTransactionHistory();
  Future<Either<Failure, dynamic>> getDashboardData();
}