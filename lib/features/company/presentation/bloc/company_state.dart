part of 'company_bloc.dart';

@Freezed()
class CompanyState with _$CompanyState {
  const factory CompanyState(
          {@Default(UIInitial()) UIStatus status,
          BlocNotifier? notification,
          List<TransactionModel>? transactionHistory,
          List<CompanyTransactionSummary>? companyTransactionSummary}) =
      _CompanyState;
}
