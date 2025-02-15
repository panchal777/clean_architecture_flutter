import 'package:clean_architecture_flutter/core/components/q_card.dart';
import 'package:clean_architecture_flutter/core/components/q_text.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/core/utils/common.dart';
import 'package:flutter/material.dart';

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
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bindRows(
          AppStrings.company,
          companyName,
          fwTitle: FontWeight.w600,
          fwValue: FontWeight.w500,
          qTTitle: QTextType.header,
          qTValue: QTextType.header,
        ),
        SizedBox(height: 10),
        bindRows(AppStrings.totalCredited, QCommon.formatDecimal(totalCredited)),
        SizedBox(height: 10),
        bindRows(AppStrings.totalDebited, QCommon.formatDecimal(totalDebited)),
        SizedBox(height: 10),
        bindRows(AppStrings.finalBalance,  QCommon.formatDecimal(finalBalance)),
        SizedBox(height: 10),
      ],
    ));
  }

  bindRows(
    String title,
    String value, {
    FontWeight? fwTitle,
    FontWeight? fwValue,
    QTextType? qTTitle,
    QTextType? qTValue,
  }) {
    return Row(
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
    );
  }
}
