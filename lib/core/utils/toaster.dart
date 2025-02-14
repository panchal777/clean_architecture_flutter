import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster {
  Toaster._();

  static void showMessage(String text, {required bool isFailure}) async {
    await Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isFailure ? Colors.red : Colors.green,
    );
  }

//
// static void s(String text) async {
//   await Fluttertoast.showToast(
//     msg: text,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: Colors.green,
//   );
// }
//
// static void e(String text) async {
//   await Fluttertoast.showToast(
//     msg: text,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: Colors.red,
//   );
// }
}
