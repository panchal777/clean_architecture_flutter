import 'package:clean_architecture_flutter/core/bloc/failure.dart';
import 'package:clean_architecture_flutter/features/company/data/data_source/company_local_src.dart';
import 'package:clean_architecture_flutter/features/company/domain/entities/company_transaction_summary.dart';
import 'package:clean_architecture_flutter/features/company/domain/entities/transaction_data_model.dart';
import 'package:clean_architecture_flutter/features/company/domain/repositories/company_repository.dart';
import 'package:dartz/dartz.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final CompanyLocalSrc companyLocalSrc;

  CompanyRepositoryImpl({required this.companyLocalSrc});

  @override
  Future<Either<Failure, List<CompanyTransactionSummary>>>
      getDashboardData() async {
    try {
      var response = await companyLocalSrc.getDashboardData();
      return Right(response);
    } catch (e, s) {
      return Left(await checkErrorState(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> saveDeposit(String amount) async {
    try {
      var response = await companyLocalSrc.saveDeposit(amount);
      return Right(response);
    } catch (e, s) {
      return Left(await checkErrorState(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> withdrawAmount(
      String amount, String companyName) async {
    try {
      var response = await companyLocalSrc.withdrawAmount(amount, companyName);
      return Right(response);
    } catch (e, s) {
      return Left(await checkErrorState(e, s));
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>>
      getTransactionHistory() async {
    try {
      var response = await companyLocalSrc.getTransactionHistory();
      return Right(response);
    } catch (e, s) {
      return Left(await checkErrorState(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTransactions() async {
    try {
      var response = await companyLocalSrc.deleteTransactions();
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
