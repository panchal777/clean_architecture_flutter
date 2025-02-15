import 'package:clean_architecture_flutter/core/components/q_card.dart';
import 'package:clean_architecture_flutter/core/components/q_text.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/core/utils/color_constant.dart';
import 'package:clean_architecture_flutter/core/utils/common.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(builder: (context, state) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.companyTransactionSummary?.length ?? 2,
              itemBuilder: (context, index) {
                var data = state.companyTransactionSummary?[index];
                // if (data != null) {
                //   savings = savings + data.totalCredited;
                //   withdraws = withdraws + data.totalDebited;
                //   debugPrint('savings---> $savings');
                // }

                return BindDashboardCard(
                  companyName: data?.companyName ?? '',
                  finalBalance: data?.finalBalance ?? 0,
                  totalCredited: data?.totalCredited ?? 0,
                  totalDebited: data?.totalDebited ?? 0,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class BindDashboardCard extends StatelessWidget {
  final String companyName;
  final double totalCredited;
  final double totalDebited;
  final double finalBalance;

  const BindDashboardCard({
    super.key,
    required this.companyName,
    required this.totalCredited,
    required this.totalDebited,
    required this.finalBalance,
  });

  @override
  Widget build(BuildContext context) {
    return QCard(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(bottom: 10),
        cardColor: ColorConstant.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: ColorConstant.deePurpleShade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: bindRows(
                AppStrings.company,
                companyName,
                fwTitle: FontWeight.w600,
                fwValue: FontWeight.w500,
                qTTitle: QTextType.header,
                qTValue: QTextType.header,
              ),
            ),
            bindRows(
                AppStrings.totalCredited, QCommon.formatDecimal(totalCredited)),
            bindRows(
                AppStrings.totalDebited, QCommon.formatDecimal(totalDebited)),
            Container(
              height: 0.2,
              width: MediaQuery.of(context).size.width,
              color: ColorConstant.dividerColor,
              margin: EdgeInsets.only(bottom: 10),
            ),
            bindRows(
                AppStrings.currentBalance, QCommon.formatDecimal(finalBalance)),
          ],
        ));
  }

  Widget bindRows(
    String title,
    String value, {
    FontWeight? fwTitle,
    FontWeight? fwValue,
    QTextType? qTTitle,
    QTextType? qTValue,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: QText(
              text: title,
              qTextType: qTTitle ?? QTextType.medium,
              fontWeight: fwTitle,
            ),
          ),
          Expanded(
            child: QText(
              text: value,
              qTextType: qTValue ?? QTextType.medium,
              fontWeight: fwValue,
            ),
          ),
        ],
      ),
    );
  }
}
