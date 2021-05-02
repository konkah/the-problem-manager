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
          return "Please enter your name";
        }
        return null;
      },
      onSaved: (String inValue) {
        nameData.yourName = inValue;
      },
      decoration: InputDecoration(
        hintText: "add your name",
        labelText: "Name",
      ),
    );
  }

  Widget personOptions() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Person who menstruate"),
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
          Text("myself"),
        ]
    );
  }

  Widget otherPersonOption() {
    return Row(
      children: [
        personOption(false),
        Text("other person"),
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
          return "Fill the name of the menstruating person";
        }
        return null;
      },
      onSaved: (String inValue) {
        nameData.personName = inValue;
      },
      decoration: InputDecoration(
        hintText: "add person name",
        labelText: "Person who menstruate",
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      child: Text("Continue"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
        }
      },
    );
  }
}