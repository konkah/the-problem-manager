import 'package:flutter/material.dart';
import 'package:the_problem_manager/controller/manage_db/manage_db_event.dart';

import '../model/user.dart';
import 'common.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State {
  @override
  Widget build(BuildContext context) {
    return nameForm();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = User();
  String password = "";

  Widget nameForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Common.title("Login"),
            Common.divider(),
            emailField(),
            passwordField(),
            Common.submitter(
                context, "entrar", formKey,
                LoginEvent(user: user),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: Common.mandatory,
      onSaved: (String inValue) {
        user.email = inValue;
      },
      decoration: InputDecoration(
        hintText: "email@site.com",
        labelText: "e-mail",
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: Common.mandatory,
      onSaved: (String inValue) {
        user.password = inValue;
      },
      onChanged: (String inValue) {
        password = inValue;
      },
      decoration: InputDecoration(
        labelText: "senha",
      ),
    );
  }
}