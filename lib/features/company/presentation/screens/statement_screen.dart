import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_card.dart';
import 'package:clean_architecture_flutter/core/components/q_text.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CompanyBloc>();

    return Scaffold(
      appBar: QAppBar(
        title: 'Statement',
      ),
      body: BlocBuilder<CompanyBloc, CompanyState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: state.status.when(
                    initial: () => Center(child: CircularProgressIndicator()),
                    loading: () => Center(child: CircularProgressIndicator()),
                    loadFailed: (message) => Center(
                        child: QText(
                            text: 'Error: $message',
                            qTextType: QTextType.header)),
                    loadSuccess: (_) => bindStatement(state),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget bindStatement(CompanyState state) {
    return state.transactionHistory == null ||
            (state.transactionHistory != null &&
                state.transactionHistory!.isEmpty)
        ? Center(
            child: QText(
            text: 'No Data Found',
            qTextType: QTextType.header,
          ))
        : ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: state.transactionHistory!.length,
            itemBuilder: (context, index) {
              var data = state.transactionHistory![index];
              return QCard(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    bindRows('Company Name:', data.companyName),
                    SizedBox(height: 8),
                    // data.isWithdraw
                    //     ? bindRows(
                    //         'Debited:',
                    //         data.withdrawalAmount.toString(),
                    //         fwValueColor: Colors.red,
                    //         fwValue: FontWeight.bold,
                    //       )
                    //     : bindRows(
                    //         'Credited:',
                    //         data.savingAmount.toString(),
                    //         fwValueColor: Colors.green,
                    //         fwValue: FontWeight.bold,
                    //       ),
                    SizedBox(height: 10),
                    bindRows(
                      'Last Transaction Amount:',
                      data.totalDeposited.toString(),
                      fwValue: FontWeight.bold,
                    ),
                    data.isWithdraw
                        ? bindRows(
                            'Debited:',
                            '- ${data.withdrawalAmount.toString()}',
                            fwValueColor: Colors.red,
                            fwValue: FontWeight.bold,
                          )
                        : bindRows(
                            'Credited:',
                            '+ ${data.savingAmount.toString()}',
                            fwValueColor: Colors.green,
                            fwValue: FontWeight.bold,
                          ),
                    Divider(),
                    bindRows(
                      'Current Amount:',
                      data.finalAmount.toString(),
                      fwValue: FontWeight.bold,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              );
            },
          );
  }

  bindRows(
    String title,
    String value, {
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
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: fwTitle, color: fwValueColor, fontSize: 14),
          ),
        ),
        SizedBox(width: 10)
      ],
    );
  }
}
