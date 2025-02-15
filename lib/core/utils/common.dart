import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QCommon {
  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String formatDecimal(double number) {
    final formatter = NumberFormat('#,##0.00'); // Keeps two decimal places
    return formatter.format(number);
  }

  static String successMsg(String amount, String label) =>
      '₹$amount $label successfully.';
}
