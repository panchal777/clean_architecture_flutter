import 'package:clean_architecture_flutter/core/bloc/bloc_notifier.dart';
import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_input.dart';
import 'package:clean_architecture_flutter/core/utils/toaster.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingAmountScreen extends StatelessWidget {
  const SavingAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController addAmountController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: QAppBar(title: 'Add to Savings'),
        body: BlocListener<CompanyBloc, CompanyState>(
          bloc: context.read<CompanyBloc>(),
          listener: (context, state) {
            if (state.notification != null &&
                state.notification!.message.isNotEmpty) {
              Toaster.showMessage(state.notification!.message,
                  isFailure: state.notification!.isFailure);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  QInput(
                    title: 'Amount',
                    controller: addAmountController,
                    isMandatory: true,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: QButton(
                      text: 'Submit',
                      onPress: () {
                        if (addAmountController.text.isNotEmpty) {
                          context
                              .read<CompanyBloc>()
                              .add(CompanyEvent.saveEntry(
                                addAmountController.text.trim(),
                              ));
                        } else {
                          Toaster.showMessage('Please fill all the mandatory fields',isFailure: true);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
