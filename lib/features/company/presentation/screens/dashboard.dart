import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_text.dart';
import 'package:clean_architecture_flutter/features/company/presentation/widgets/bind_dashboard_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: QAppBar(title: 'Dashboard'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                BindDashboardCard(
                    companyName: 'A', savings: '0', withdraw: '0'),
                SizedBox(height: 8),
                BindDashboardCard(
                    companyName: 'B', savings: '0', withdraw: '0'),
                SizedBox(height: 8),
                bindRows(
                  title: 'Add to Bank Balance',
                  btnText: 'Savings',
                  qBtnType: QButtonType.tonal,
                  onPressed: () {},
                ),
                bindRows(
                  title: 'Withdraw amount',
                  btnText: 'Withdraw',
                  qBtnType: QButtonType.tonal,
                  onPressed: () {},
                ),
                bindRows(
                  title: 'Check History',
                  btnText: 'Statement',
                  qBtnType: QButtonType.filled,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bindRows({
    required String title,
    required String btnText,
    required QButtonType qBtnType,
    required Function onPressed,
  }) {
    return Row(
      children: [
        Expanded(
          child: QText(
            text: title,
            qTextType: QTextType.medium,
            fontWeight: FontWeight.w500,
          ),
        ),
        QButton(
          text: btnText,
          type: qBtnType,
          onPress: () => onPressed,
        ),
      ],
    );
  }
}
