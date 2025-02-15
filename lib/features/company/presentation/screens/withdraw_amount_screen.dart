import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_input.dart';
import 'package:clean_architecture_flutter/core/utils/input_formatters.dart';
import 'package:clean_architecture_flutter/core/utils/toaster.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithdrawAmountScreen extends StatelessWidget {
  const WithdrawAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController withdrawAmountController = TextEditingController();
    String companyName = '';

    return SafeArea(
      child: Scaffold(
        appBar: QAppBar(title: 'Withdraw from Account'),
        body: BlocListener<CompanyBloc, CompanyState>(
          bloc: context.read<CompanyBloc>(),
          listener: (context, state) {
            if (state.notification != null &&
                state.notification!.message.isNotEmpty) {
              Toaster.showMessage(state.notification!.message,
                  isFailure: state.notification!.isFailure);
              withdrawAmountController.text = '';
              companyName = '';
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  QInput(
                    title: 'Select Company',
                    onChanged: (value) {
                      companyName = value;
                    },
                  ),
                  SizedBox(height: 8),
                  QInput(
                    title: 'Amount',
                    isMandatory: true,
                    controller: withdrawAmountController,
                    keyBoardType: TextInputType.number,
                    inputFormatters: QInputFormatter.allowOnlyDigits(),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: QButton(
                      text: 'Submit',
                      onPress: () {
                        if (withdrawAmountController.text.isNotEmpty &&
                            companyName.isNotEmpty) {
                          debugPrint(
                              'Withdraw amount -> ${withdrawAmountController.text}');

                          context.read<CompanyBloc>().add(
                              CompanyEvent.withdrawAmount(
                                  withdrawAmountController.text, companyName));
                        } else {
                          Toaster.showMessage(
                              'Please fill all the mandatory fields',
                              isFailure: true);
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
