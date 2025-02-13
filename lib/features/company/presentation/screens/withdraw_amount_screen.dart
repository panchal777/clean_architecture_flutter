import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_input.dart';
import 'package:flutter/material.dart';

class WithdrawAmountScreen extends StatelessWidget {
  const WithdrawAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController withdrawAmountController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: QAppBar(title: 'Withdraw from Account'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                QInput(
                  title: 'Select Company',
                ),
                SizedBox(height: 8),
                QInput(
                  title: 'Amount',
                  controller: withdrawAmountController,
                ),
                SizedBox(height: 30),
                Center(
                  child: QButton(
                    text: 'Submit',
                    onPress: () {
                      if (withdrawAmountController.text.isNotEmpty) {
                        debugPrint(
                            'Withdraw amount -> ${withdrawAmountController.text}');
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
