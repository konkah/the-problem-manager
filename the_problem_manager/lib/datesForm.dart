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
            Text("Cadastrar mentruação"),
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
          return "coloque uma data válida ou deixe em branco";
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
        hintText: "dd/mm/yyyy",
        labelText: "início",
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
          return "coloque uma data válida ou deixe em branco";
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
        hintText: "dd/mm/yyyy",
        labelText: "fim",
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