import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/manage_db/manage_db_event.dart';
import '../controller/manage_db/manage_db_bloc.dart';

class Common {
  static MaterialColor mainColor = Colors.indigo;
  static MaterialColor tpmColor = Colors.red;

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

  static Widget submitter(BuildContext context, String text, GlobalKey<FormState> formKey, ManageEvent event) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        child: Text(text),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            BlocProvider.of<ManageBloc>(context).add(event);
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
