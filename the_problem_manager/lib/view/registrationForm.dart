import 'package:flutter/material.dart';

import '../model/registration.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State {
  @override
  Widget build(BuildContext context) {
    return nameForm();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Registration registration = Registration();
  String password = "";

  Widget nameForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            title("Cadastro"),
            divider(),
            yourNameField(),
            emailField(),
            passwordField(),
            retypePasswordField(),
            divider(),
            title("sobre a pessoa que menstrua..."),
            divider(),
            personOptions(),
            button(),
          ],
        ),
      ),
    );
  }

  Text title(String message) {
    return Text(message,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  Divider divider() {
    return Divider(
      thickness: 5,
      color: Colors.greenAccent,
      height: 30,
    );
  }

  Widget yourNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      validator: mandatory,
      onSaved: (String inValue) {
        registration.yourName = inValue;
      },
      decoration: InputDecoration(
        hintText: "como quer te chamemos?",
        labelText: "nome que prefere que te chamem",
      ),
    );
  }

  Widget personOptions() {
    return Column(
      children: [
        options(),
        otherPersonName(),
      ],
    );
  }

  Widget options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        personOption(true),
        Text("sou eu"),
        personOption(false),
        Text("outra pessoa"),
      ],
    );
  }

  Widget personOption(bool value) {
    return Radio(
      value: value,
      groupValue: registration.samePerson,
      onChanged: (bool inValue) {
        setState(() {
          registration.samePerson = inValue;
        });
      },
    );
  }

  Widget otherPersonName() {
    return TextFormField(
      enabled: !registration.samePerson,
      keyboardType: TextInputType.name,
      validator: (String inValue) {
        if (inValue.length == 0 && !registration.samePerson) {
          return "campo obrigatório";
        }
        return null;
      },
      onSaved: (String inValue) {
        registration.personName = inValue;
      },
      decoration: InputDecoration(
        hintText: "quem você vai presentear com chocolate?",
        labelText: "nome da pessoa",
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: mandatory,
      onSaved: (String inValue) {
        registration.email = inValue;
      },
      decoration: InputDecoration(
        hintText: "email@domain.com",
        labelText: "e-mail",
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: mandatory,
      onSaved: (String inValue) {
        registration.password = inValue;
      },
      onChanged: (String inValue) {
        password = inValue;
      },
      decoration: InputDecoration(
        labelText: "senha",
      ),
    );
  }

  Widget retypePasswordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (inValue) {
        if (inValue != password)
          return "senhas precisam ser iguais";

        return null;
      },
      decoration: InputDecoration(
        labelText: "redigite a senha",
      ),
    );
  }

  String mandatory(String inValue) {
    if (inValue.length == 0) {
      return "campo obrigatório";
    }
    return null;
  }

  Widget button() {
    return ElevatedButton(
      child: Text("salvar"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
        }
      },
    );
  }
}