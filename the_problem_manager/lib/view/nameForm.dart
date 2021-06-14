import 'package:flutter/material.dart';

import '../model/names.dart';

class NameForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NameFormState();
  }
}

class NameFormState extends State {
  @override
  Widget build(BuildContext context) {
    return nameForm();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Names names = Names();
  String password = "";

  Widget nameForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Cadastro"),
            yourNameField(),
            Divider(),
            Text("Pessoa que menstrua:"),
            personOptions(),
            loginField(),
            passwordField(),
            retypePasswordField(),
            button(),
          ],
        ),
      ),
    );
  }

  Widget yourNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      validator: mandatory,
      onSaved: (String inValue) {
        names.yourName = inValue;
      },
      decoration: InputDecoration(
        hintText: "insira seu nome",
        labelText: "Nome do usuário",
      ),
    );
  }

  Widget personOptions() {
    return Column(
      children: [
        myselfOption(),
        otherPersonOption(),
        otherPersonName(),
      ],
    );
  }

  Widget myselfOption() {
    return Row(
        children: [
          personOption(true),
          Text("sou eu"),
        ]
    );
  }

  Widget otherPersonOption() {
    return Row(
      children: [
        personOption(false),
        Text("outra pessoa"),
      ],
    );
  }

  Widget personOption(bool value) {
    return Radio(
      value: value,
      groupValue: names.samePerson,
      onChanged: (bool inValue) {
        setState(() {
          names.samePerson = inValue;
        });
      },
    );
  }

  Widget otherPersonName() {
    return TextFormField(
      enabled: !names.samePerson,
      keyboardType: TextInputType.name,
      validator: (String inValue) {
        if (inValue.length == 0 && !names.samePerson) {
          return "campo obrigatório";
        }
        return null;
      },
      onSaved: (String inValue) {
        names.personName = inValue;
      },
      decoration: InputDecoration(
        hintText: "insira o nome da pessoa que menstrua",
        labelText: "Nome da pessoa",
      ),
    );
  }

  Widget loginField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: mandatory,
      onSaved: (String inValue) {
        names.email = inValue;
      },
      decoration: InputDecoration(
        hintText: "email@domain.com",
        labelText: "E-mail",
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: mandatory,
      onSaved: (String inValue) {
        names.password = inValue;
      },
      onChanged: (String inValue) {
        password = inValue;
      },
      decoration: InputDecoration(
        labelText: "Senha",
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
        labelText: "Redigite a Senha",
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