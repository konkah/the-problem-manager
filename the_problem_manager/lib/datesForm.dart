import 'package:flutter/material.dart';

import 'datesData.dart';

class DatesForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DatesFormState();
  }
}

class DatesFormState extends State {
  @override
  Widget build(BuildContext context) {
    return nameForm();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatesData datesData = DatesData();

  Widget nameForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            startField(),
            endField(),
            button(),
          ],
        ),
      ),
    );
  }

  Widget startField() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      validator: (String inValue) {
        if (inValue.length == 0) {
          return null;
        }

        if (DateTime.tryParse(inValue) == null) {
          return "Please enter a valid date or no date";
        }

        return null;
      },
      onSaved: (String inValue) {
        if (inValue.length == 0) {
          return null;
        }

        datesData.start = DateTime.parse(inValue);
      },
      decoration: InputDecoration(
        hintText: "add the start date",
        labelText: "Start",
      ),
    );
  }

  Widget endField() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      validator: (String inValue) {
        if (inValue.length == 0) {
          return null;
        }

        if (DateTime.tryParse(inValue) == null) {
          return "Please enter a valid date or no date";
        }

        return null;
      },
      onSaved: (String inValue) {
        if (inValue.length == 0) {
          return null;
        }

        datesData.end = DateTime.parse(inValue);
      },
      decoration: InputDecoration(
        hintText: "add the end date",
        labelText: "End",
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      child: Text("Continue"),
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
        content: Text("Information saved successfully!"),
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