import 'package:clean_architecture_flutter/core/bloc/failure.dart';
import 'package:clean_architecture_flutter/features/company/data/data_source/company_local_src.dart';
import 'package:clean_architecture_flutter/features/company/domain/repositories/company_repository.dart';
import 'package:dartz/dartz.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final CompanyLocalSrc companyLocalSrc;

  CompanyRepositoryImpl({required this.companyLocalSrc});

  @override
  Future<Either<Failure, dynamic>> getDashboardData() async {
    try {
      var response = await companyLocalSrc.getDashboardData();
      return Right(response);
    } catch (e, s) {
      return Left(await checkErrorState(e, s));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getTransactionHistory() async {
    try {
      var response = await companyLocalSrc.getTransactionHistory();
      return Right(response);
    } catch (e, s) {
      return Left(await checkErrorState(e, s));
    }
  }

  @override
  Future<Either<Failure, dynamic>> saveEntry(String amount) async {
    try {
      var response = await companyLocalSrc.saveEntry(amount);
      return Right(response);
    } catch (e, s) {
      return Left(await checkErrorState(e, s));
    }
  }

  @override
  Future<Either<Failure, dynamic>> withdrawAmount(
      String amount, String companyName) async {
    try {
      var response = await companyLocalSrc.withdrawAmount(amount, companyName);
      return Right(response);
    } catch (e, s) {
      return Left(await checkErrorState(e, s));
    }
  }

  /*---------Error Handling----------*/
  Future<Failure> checkErrorState(e, StackTrace s) async {
    return FailureMessage(e.toString());
  }
}
