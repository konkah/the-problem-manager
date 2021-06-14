import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_problem_manager/controller/manage_db/manage_db_bloc.dart';
import 'package:the_problem_manager/controller/manage_db/manage_db_event.dart';

import '../model/dates.dart';

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
  Dates datesForm = Dates();

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
      onSaved: (String inValue) {
        if (inValue.length == 0) {
          return null;
        }

        datesForm.start = inValue;
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
      onSaved: (String inValue) {
        if (inValue.length == 0) {
          return null;
        }

        datesForm.end = inValue;
      },
      decoration: InputDecoration(
        hintText: "dd/mm/yyyy",
        labelText: "fim",
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      child: Text("salvar"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();

          BlocProvider.of<ManageBloc>(context)
            .add(InsertEvent(dates: datesForm));
        }
      },
    );
  }
}