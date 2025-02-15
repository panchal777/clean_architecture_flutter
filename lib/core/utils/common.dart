import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QCommon {
  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String formatDecimal(double number) {
    try {
      // double number = double.parse(value.replaceAll(',', ''));
      return NumberFormat('#,##0.00').format(number);
    } catch (e) {
      return number.toString();
    }
  }

  static String successMsg(String amount, String label) =>
      '₹$amount $label successfully.';
}
