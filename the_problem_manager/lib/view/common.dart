import 'package:flutter/material.dart';

class Common {
  static MaterialColor mainColor = Colors.red;

  static Text title(String message) {
    return Text(message,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  static Divider divider() {
    return Divider(
      thickness: 3,
      color: Colors.blueGrey,
      height: 30,
    );
  }

  static Divider dividerTransparent() {
    return Divider(
      thickness: 3,
      color: Colors.transparent,
      height: 30,
    );
  }

  static void showMessage(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          duration: Duration(seconds: 5),
          content: Text(message),
          action: SnackBarAction(
            label: "Ok",
            onPressed: () { },
          ),
        )
    );
  }}
