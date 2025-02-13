import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_input.dart';
import 'package:flutter/material.dart';

class SavingAmountScreen extends StatelessWidget {
  const SavingAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController addAmountController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: QAppBar(title: 'Add to Savings'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                QInput(
                  title: 'Amount',
                  controller: addAmountController,
                ),
                SizedBox(height: 30),
                Center(
                  child: QButton(
                    text: 'Submit',
                    onPress: () {
                      if (addAmountController.text.isNotEmpty) {
                        debugPrint(
                            'Add to Saving amount -> ${addAmountController.text}');
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
