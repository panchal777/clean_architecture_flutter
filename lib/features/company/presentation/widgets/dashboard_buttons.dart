import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_text.dart';
import 'package:clean_architecture_flutter/core/router/app_router.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bindRows(
          title: AppStrings.addToBankBalance,
          btnText: AppStrings.deposit,
          qBtnType: QButtonType.filled,
          onPressed: () {
            navigateToNextPage(AppRouteName.saving, context);
          },
        ),
        bindRows(
          title: AppStrings.withdrawAmount,
          btnText: AppStrings.withdraw,
          qBtnType: QButtonType.filled,
          onPressed: () {
            navigateToNextPage(AppRouteName.withdraw, context);
          },
        ),
        bindRows(
          title: AppStrings.transactionHistory,
          btnText: AppStrings.statement,
          qBtnType: QButtonType.filled,
          onPressed: () {
            navigateToNextPage(AppRouteName.statement, context);
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
          flex: 5,
          child: QText(
            text: title,
            qTextType: QTextType.medium,
            fontWeight: FontWeight.normal,
          ),
        ),
        Expanded(
          flex: 2,
          child: QButton(
            text: btnText,
            type: qBtnType,
            state: QButtonState.enabled,
            onPress: () {
              onPressed!();
            },
          ),
        ),
      ],
    );
  }

  navigateToNextPage(String routeName, BuildContext context) {
    context.pushNamed(routeName).then((value) {
      if (context.mounted) {
        refreshList(context);
      }
    });
  }

  refreshList(BuildContext context) {
    context.read<CompanyBloc>().add(CompanyEvent.getDashboardData());
  }
}
