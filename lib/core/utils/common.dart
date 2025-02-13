import 'package:flutter/material.dart';

class QCommon {
  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
