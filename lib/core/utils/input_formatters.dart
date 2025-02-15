import 'package:flutter/services.dart';

class QInputFormatter {
  static allowOnlyDigits() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(10)
    ];
  }
}
