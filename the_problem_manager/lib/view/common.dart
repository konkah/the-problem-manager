import 'package:flutter/material.dart';

class Common {
  static MaterialColor mainColor = Colors.indigo;

  static Text title(String message) {
    return Text(message,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
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

  static String mandatory(String inValue) {
    if (inValue.length == 0) {
      return "campo obrigatório";
    }
    return null;
  }

  static Widget button(GlobalKey<FormState> formKey, String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        child: Text(text),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
      ),
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
  }
}
