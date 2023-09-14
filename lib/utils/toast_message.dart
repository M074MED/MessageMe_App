import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  final String message;
  final Color bgColor;
  const ToastMessage({required this.message, required this.bgColor});

  void show() {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        webBgColor: bgColor == Colors.green ? "#00ff00" : "#ff0000",
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
