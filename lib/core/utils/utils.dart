import 'package:flutter/material.dart';

class Utils {
  static final messengerkey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text, bool error) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: error == true ? Colors.red : Colors.green,
    );
    messengerkey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
