import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_text.dart';
import 'package:clean_architecture_flutter/core/router/app_router.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:clean_architecture_flutter/features/company/presentation/widgets/bind_dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var savings = 0.0;

  var withdraws = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: QAppBar(title: 'Dashboard', hideBackPressed: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<CompanyBloc, CompanyState>(
                    builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              state.companyTransactionSummary?.length ?? 2,
                          itemBuilder: (context, index) {
                            var data = state.companyTransactionSummary?[index];
                            if (data != null) {
                              savings = savings + data.totalCredited;
                              withdraws = withdraws + data.totalDebited;
                              debugPrint('savings---> $savings');
                            }

                            return BindDashboardCard(
                              companyName: data?.companyName ?? '',
                              finalBalance: data?.finalBalance ?? 0,
                              totalCredited: data?.totalCredited ?? 0,
                              totalDebited: data?.totalDebited ?? 0,
                            );
                          },
                        ),
                      ),
                      Text('Savings: $savings'),
                      Text('Withdraws: $withdraws'),
                    ],
                  );
                }),
              ),
              bindButtons(context)
            ],
          ),
        ),
      ),
    );
  }

  bindButtons(BuildContext context) {
    return Column(
      children: [
        bindRows(
          title: 'Add to Bank Balance',
          btnText: 'Savings',
          qBtnType: QButtonType.tonal,
          onPressed: () {
            context.pushNamed(AppRouteName.saving);
          },
        ),
        bindRows(
          title: 'Withdraw amount',
          btnText: 'Withdraw',
          qBtnType: QButtonType.tonal,
          onPressed: () {
            context.pushNamed(AppRouteName.withdraw);
          },
        ),
        bindRows(
          title: 'Check History',
          btnText: 'Statement',
          qBtnType: QButtonType.filled,
          onPressed: () {
            context.pushNamed(AppRouteName.statement);
          },
        ),
      ],
    );
  }

  bindRows(
      {required String title,
      required String btnText,
      required QButtonType qBtnType,
      required Function()? onPressed}) {
    return Row(
      children: [
        Expanded(
          child: QText(
            text: title,
            qTextType: QTextType.medium,
            fontWeight: FontWeight.normal,
          ),
        ),
        QButton(
          text: btnText,
          type: qBtnType,
          state: QButtonState.enabled,
          onPress: () {
            onPressed!();
          },
        ),
      ],
    );
  }

  refreshList(BuildContext context) {
    context.read<CompanyBloc>().add(CompanyEvent.getDashboardData());
  }
}
