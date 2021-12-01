import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String message,
  required toastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum toastStates {
  success,
  error,
  warning,
}

Color? chooseToastColor(toastStates state) {
  Color color;

  switch (state) {
    case toastStates.success:
      color = Colors.green;
      break;
    case toastStates.error:
      color = Colors.red;
      break;
    case toastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}
