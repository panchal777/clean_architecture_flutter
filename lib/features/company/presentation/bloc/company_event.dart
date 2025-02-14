part of 'company_bloc.dart';

@Freezed()
class CompanyEvent with _$CompanyEvent {
  const factory CompanyEvent.loaded() = _Loaded;

  const factory CompanyEvent.fetchTransactionHistory() = _GetTransactionHistory;

  const factory CompanyEvent.saveEntry(String amount) = _SaveEntry;

  const factory CompanyEvent.withdrawAmount(String amount,String companyName) =_WithdrawAmount ;

  const factory CompanyEvent.getDashboardData() = _GetDashboardData;
}
