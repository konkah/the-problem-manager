import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_problem_manager/controller/remote/manage_db/manage_db_state.dart';
import 'package:the_problem_manager/controller/remote/manage_db/manage_db_bloc.dart';
import 'package:the_problem_manager/controller/remote/manage_db/manage_db_event.dart';
import 'package:the_problem_manager/helper/date.dart';

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
      child: BlocListener<ManageBloc, ManageState>(
        listener: (context, state) {
          formKey.currentState.reset();
        },
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
      ),
    );
  }

  String dateValidator(String inValue) {
    try
    {
      DateTime date = Date.parse(inValue);
      String text = Date.format(date);

      if (inValue == text)
        return null;
    }
    catch (Exception) { }

    return "Data inválida";
  }

  Widget startField() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      validator: this.dateValidator,
      onSaved: (String inValue) {
        datesForm.start = Date.parse(inValue);
      },
      decoration: InputDecoration(
        hintText: Date.pattern,
        labelText: "início",
      ),
    );
  }

  Widget endField() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      validator: this.dateValidator,
      onSaved: (String inValue) {
        datesForm.end = Date.parse(inValue);
      },
      decoration: InputDecoration(
        hintText: Date.pattern,
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