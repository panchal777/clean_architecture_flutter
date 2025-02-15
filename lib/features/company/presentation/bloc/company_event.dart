part of 'company_bloc.dart';

@Freezed()
class CompanyEvent with _$CompanyEvent {
  const factory CompanyEvent.loaded() = _Loaded;

  const factory CompanyEvent.getTransactionHistory() = _GetTransactionHistory;

  const factory CompanyEvent.saveDeposit(String amount) = _SaveDeposit;

  const factory CompanyEvent.withdrawAmount(String amount,String companyName) =_WithdrawAmount ;

  const factory CompanyEvent.getDashboardData() = _GetDashboardData;
}
