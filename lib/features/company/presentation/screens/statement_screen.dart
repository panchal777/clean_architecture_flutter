import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_card.dart';
import 'package:clean_architecture_flutter/core/components/q_text.dart';
import 'package:clean_architecture_flutter/core/utils/common.dart';
import 'package:clean_architecture_flutter/core/utils/toaster.dart';
import 'package:clean_architecture_flutter/features/company/domain/entities/transaction_data_model.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CompanyBloc>();

    return Scaffold(
      appBar: QAppBar(title: 'Statement'),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.notification != null &&
              state.notification!.message.isNotEmpty) {
            Toaster.showMessage(state.notification!.message,
                isFailure: state.notification!.isFailure);
          }
          if (state.isTransactionDeleted) {
            context.pop();
          }
        },
        builder: (context, state) {
          return state.status.when(
            initial: () => Center(child: CircularProgressIndicator()),
            loading: () => Center(child: CircularProgressIndicator()),
            loadFailed: (message) => Center(
                child: QText(
                    text: 'Error: $message', qTextType: QTextType.header)),
            loadSuccess: (_) => bindStatement(state, context),
          );
        },
      ),
    );
  }

  Widget bindStatement(CompanyState state, BuildContext context) {
    return state.transactionHistory == null ||
            (state.transactionHistory != null &&
                state.transactionHistory!.isEmpty)
        ? Center(
            child: QText(
            text: 'No Data Found',
            qTextType: QTextType.header,
          ))
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                bindMainCard(state.transactionHistory),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transaction History'),
                    InkWell(
                      onTap: () {
                        context
                            .read<CompanyBloc>()
                            .add(CompanyEvent.deleteTransactions());
                      },
                      child: Row(
                        children: [
                          Text('Clear Records'),
                          SizedBox(width: 10),
                          Icon(Icons.delete_forever)
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    // padding: EdgeInsets.all(8),
                    itemCount: state.transactionHistory!.length,
                    itemBuilder: (context, index) {
                      var data = state.transactionHistory![index];
                      return QCard(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            bindRows('Company Name:', data.companyName),
                            SizedBox(height: 10),
                            bindRows(
                              'Last Transaction Amount:',
                              QCommon.formatDecimal(data.totalDeposited),
                            ),
                            data.isWithdraw
                                ? bindRows(
                                    'Debited:',
                                    '- ${QCommon.formatDecimal(data.withdrawalAmount)}',
                                    fwValueColor: Colors.red,
                                  )
                                : bindRows(
                                    'Credited:',
                                    '+ ${(QCommon.formatDecimal(data.savingAmount))}',
                                    fwValueColor: Colors.green,
                                  ),
                            Divider(),
                            bindRows(
                              'Current Amount:',
                              QCommon.formatDecimal(data.finalAmount),
                              fwValue: FontWeight.bold,
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget bindMainCard(List<TransactionModel>? transactionHistory) {
    return QCard(
      cardColor: Colors.deepPurple.shade50,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          bindRows('Total Savings', getTotalSavings(transactionHistory!),
              fwValueColor: Colors.green,
              fwValue: FontWeight.bold,
              fwTitle: FontWeight.bold),
          SizedBox(height: 10),
          bindRows('Withdraws from Company A',
              getTotalWithdrawals(transactionHistory, 'A'),
              fwValueColor: Colors.red),
          SizedBox(height: 10),
          bindRows('Withdraws from Company B',
              getTotalWithdrawals(transactionHistory, 'B'),
              fwValueColor: Colors.red),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  String getTotalSavings(List<TransactionModel> transactionHistory) {
    var totalSavingsA = sortAndSearchTransactions(transactionHistory, 'A');
    var totalSavingsB = sortAndSearchTransactions(transactionHistory, 'B');
    return QCommon.formatDecimal((totalSavingsA + totalSavingsB)).toString();
  }

  sortAndSearchTransactions(
      List<TransactionModel> transactionHistory, String companyName) {
    return transactionHistory
        .where((element) => element.companyName == companyName)
        .first
        .finalAmount;
  }

  String getTotalWithdrawals(
      List<TransactionModel>? transactionHistory, String companyName) {
    var amount = transactionHistory!
        .where((element) =>
            element.companyName == companyName) // Filter by company name
        .map((transaction) =>
            transaction.withdrawalAmount) // Extract withdrawal amounts
        .fold(0.0, (sum, amount) => sum + amount); // Safely sum them up
    return QCommon.formatDecimal(amount);
  }

  Widget bindRows(
    String title,
    dynamic value, {
    FontWeight? fwTitle,
    FontWeight? fwValue,
    Color? fwTitleColor,
    Color? fwValueColor,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: fwTitle, color: fwTitleColor, fontSize: 14),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value.toString(),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: fwValue, color: fwValueColor, fontSize: 14),
          ),
        ),
        SizedBox(width: 10)
      ],
    );
  }
}
