import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/core/components/q_button.dart';
import 'package:clean_architecture_flutter/core/components/q_card.dart';
import 'package:clean_architecture_flutter/core/components/q_drop_down.dart';
import 'package:clean_architecture_flutter/core/components/q_input.dart';
import 'package:clean_architecture_flutter/core/router/app_router.dart';
import 'package:clean_architecture_flutter/core/utils/app_strings.dart';
import 'package:clean_architecture_flutter/core/utils/input_formatters.dart';
import 'package:clean_architecture_flutter/core/utils/toaster.dart';
import 'package:clean_architecture_flutter/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WithdrawAmountScreen extends StatefulWidget {
  const WithdrawAmountScreen({super.key});

  @override
  State<WithdrawAmountScreen> createState() => _WithdrawAmountScreenState();
}

class _WithdrawAmountScreenState extends State<WithdrawAmountScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController withdrawAmountController = TextEditingController();
    String companyName = '';
    List<String> companies = ['A', 'B'];

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

              if (!state.notification!.isFailure) {
                withdrawAmountController.text = '';
                companyName = '';
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
                    QDropDown(
                      title: AppStrings.company,
                      dropDownList: companies,
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
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: QButton(
                          text: 'Submit',
                          onPress: () {
                            if (withdrawAmountController.text.isNotEmpty &&
                                companyName.isNotEmpty) {
                              debugPrint(
                                  'Withdraw amount -> ${withdrawAmountController.text}');

                              context.read<CompanyBloc>().add(
                                  CompanyEvent.withdrawAmount(
                                      withdrawAmountController.text,
                                      companyName));
                            } else {
                              Toaster.showMessage(
                                  'Please fill all the mandatory fields',
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
