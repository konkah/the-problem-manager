import 'package:flutter/material.dart';

import 'nameData.dart';

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
  NameData nameData = NameData();

  Widget nameForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Dados das pessoas"),
            yourNameField(),
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
        nameData.yourName = inValue;
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
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Pessoa que menstrua"),
        ),
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
      groupValue: nameData.samePerson,
      onChanged: (bool inValue) {
        setState(() {
          nameData.samePerson = inValue;
        });
      },
    );
  }

  Widget otherPersonName() {
    return TextFormField(
      enabled: !nameData.samePerson,
      keyboardType: TextInputType.name,
      validator: (String inValue) {
        if (inValue.length == 0 && !nameData.samePerson) {
          return "campo obrigatório";
        }
        return null;
      },
      onSaved: (String inValue) {
        nameData.personName = inValue;
      },
      decoration: InputDecoration(
        hintText: "coloque o nome da pessoa",
        labelText: "pessoa que menstrua",
      ),
    );
  }

  Widget button() {
    return RaisedButton(
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