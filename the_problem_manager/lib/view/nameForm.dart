import 'package:flutter/material.dart';

import '../model/nameModel.dart';

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
  NameModel nameModel = NameModel();

  Widget nameForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Dados das pessoas"),
            yourNameField(),
            Divider(),
            Text("Usuário"),
            Divider(),
            Divider(),
            Text("Pessoa que menstrua:", textAlign: TextAlign.left,),
            personOptions(),
            button(),
          ],
        ),
      ),
    );
  }

  Widget yourNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      validator: (String inValue) {
        if (inValue.length == 0) {
          return "campo obrigatório";
        }
        return null;
      },
      onSaved: (String inValue) {
        nameModel.yourName = inValue;
      },
      decoration: InputDecoration(
        hintText: "insira seu nome",
        labelText: "Seu nome",
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
      groupValue: nameModel.samePerson,
      onChanged: (bool inValue) {
        setState(() {
          nameModel.samePerson = inValue;
        });
      },
    );
  }

  Widget otherPersonName() {
    return TextFormField(
      enabled: !nameModel.samePerson,
      keyboardType: TextInputType.name,
      validator: (String inValue) {
        if (inValue.length == 0 && !nameModel.samePerson) {
          return "campo obrigatório";
        }
        return null;
      },
      onSaved: (String inValue) {
        nameModel.personName = inValue;
      },
      decoration: InputDecoration(
        hintText: "coloque o nome da pessoa",
        labelText: "pessoa que menstrua",
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      child: Text("salvar"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          showSuccess();
        }
      },
    );
  }

  void showSuccess() {
    // deprecated: vai sumir da linguagem
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 5),
        content: Text("Informação salva com sucesso!"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {
            print("closed snack bar");
          },
        ),
      )
    );
  }
}