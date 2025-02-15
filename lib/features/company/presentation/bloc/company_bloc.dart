import 'dart:async';
import 'package:clean_architecture_flutter/core/bloc/bloc_notifier.dart';
import 'package:clean_architecture_flutter/core/bloc/failure.dart';
import 'package:clean_architecture_flutter/core/bloc/ui_status.dart';
import 'package:clean_architecture_flutter/core/utils/common.dart';
import 'package:clean_architecture_flutter/features/company/domain/entities/company_transaction_summary.dart';
import 'package:clean_architecture_flutter/features/company/domain/entities/transaction_data_model.dart';
import 'package:clean_architecture_flutter/features/company/domain/repositories/company_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_bloc.freezed.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  late final CompanyRepository _companyRepository;

  CompanyBloc({
    required CompanyRepository companyRepository,
  }) : super(const CompanyState()) {
    _companyRepository = companyRepository;
    on<_SaveDeposit>(_saveDeposit);
    on<_WithdrawAmount>(_withdrawAmount);
    on<_GetTransactionHistory>(_getTransactionHistory);
    on<_GetDashboardData>(_getDashboardData);
    on<_DeleteTransactions>(_deleteTransactions);
  }

  Future<void> _saveDeposit(
    _SaveDeposit event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: UILoading(), notification: null));
    var data = await _companyRepository.saveDeposit(event.amount);
    data.fold(
      (onError) {
        generalErrorMessageListener(onError, emit);
      },
      (isDataSaved) {
        if (isDataSaved) {
          emit(state.copyWith(
              status: UILoadSuccess(),
              notification: BlocNotifier.success(
                  message: QCommon.successMsg(
                event.amount,
                'deposited',
              ))));

          //refreshing dashboard
          //add(CompanyEvent.getDashboardData());
        }
      },
    );
  }

  Future<void> _withdrawAmount(
    _WithdrawAmount event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: UILoading(), notification: null));
    var data = await _companyRepository.withdrawAmount(
        event.amount, event.companyName);
    data.fold(
      (onError) {
        generalErrorMessageListener(onError, emit);
      },
      (isAmountWithdraw) {
        if (isAmountWithdraw) {
          emit(state.copyWith(
              status: UILoadSuccess(),
              notification: BlocNotifier.success(
                  message: QCommon.successMsg(
                event.amount,
                'withdraw',
              ))));
          //refreshing dashboard
          //add(CompanyEvent.getDashboardData());
        }
      },
    );
  }

  Future<void> _getDashboardData(
    _GetDashboardData event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(
        status: UILoading(),
        notification: null,
        companyTransactionSummary: []));
    var data = await _companyRepository.getDashboardData();
    data.fold(
      (onError) {
        generalErrorHandlingUI(onError, emit);
      },
      (response) {
        emit(state.copyWith(
            status: UILoadSuccess(), companyTransactionSummary: response));
      },
    );
  }

  Future<void> _getTransactionHistory(
    _GetTransactionHistory event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: UILoading(), notification: null));
    var data = await _companyRepository.getTransactionHistory();
    data.fold(
      (onError) {
        generalErrorHandlingUI(onError, emit);
      },
      (response) {
        emit(state.copyWith(
            transactionHistory: response, status: UILoadSuccess()));
      },
    );
  }

  Future<void> _deleteTransactions(
    _DeleteTransactions event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: UILoading(), notification: null));
    var data = await _companyRepository.deleteTransactions();
    data.fold(
      (onError) {
        generalErrorMessageListener(onError, emit);
      },
      (isTransactionDeleted) {
        emit(state.copyWith(
            status: UILoadSuccess(),
            notification: BlocNotifier.success(message: 'Records deleted'),
            isTransactionDeleted: true,
            transactionHistory: []));
      },
    );
  }

  /*-------------------------------------------------------------------*/

  //call when binding error to ui widget
  generalErrorHandlingUI(Failure onError, Emitter<CompanyState> emit) {
    emit(state.copyWith(
        status: UIStatus.loadFailed(message: getErrorMessage(onError))));
  }

  //call when binding error to listen on ui
  generalErrorMessageListener(Failure onError, Emitter<CompanyState> emit) {
    emit(state.copyWith(
        notification: BlocNotifier.failed(
            message: getErrorMessage(onError), isFailure: true)));
  }

  String getErrorMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is InternetFailure) {
      return failure.message;
    } else if (failure is FailureMessage) {
      return failure.message;
    } else {
      return 'Something went wrong';
    }
  }
}
