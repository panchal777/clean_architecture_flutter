import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_card.dart';
import 'package:clean_architecture_flutter/core/components/q_input.dart';
import 'package:clean_architecture_flutter/core/router/app_router.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/core/utils/input_formatters.dart';
import 'package:clean_architecture_flutter/core/utils/toaster.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DepositAmountScreen extends StatelessWidget {
  const DepositAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController addAmountController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: QAppBar(title: AppStrings.deposit),
        body: BlocListener<CompanyBloc, CompanyState>(
          bloc: context.read<CompanyBloc>(),
          listener: (context, state) {
            if (state.notification != null &&
                state.notification!.message.isNotEmpty) {
              Toaster.showMessage(state.notification!.message,
                  isFailure: state.notification!.isFailure);

              addAmountController.text = '';
              if (!state.notification!.isFailure) {
                context.pop();
                context.pushNamed(AppRouteName.statement);
              }
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: QCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    QInput(
                      title: AppStrings.amount,
                      controller: addAmountController,
                      isMandatory: true,
                      keyBoardType: TextInputType.number,
                      inputFormatters: QInputFormatter.allowOnlyDigits(),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: QButton(
                          text: AppStrings.submit,
                          onPress: () {
                            if (addAmountController.text.isNotEmpty) {
                              context
                                  .read<CompanyBloc>()
                                  .add(CompanyEvent.saveDeposit(
                                    addAmountController.text.trim(),
                                  ));
                            } else {
                              Toaster.showMessage(AppStrings.validationErrorMsg,
                                  isFailure: true);
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
