import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/manage_db/manage_db_event.dart';
import '../../controller/manage_db/manage_db_state.dart';
import '../../controller/manage_db/manage_db_bloc.dart';
import '../../helper/date.dart';
import '../../model/period.dart';

import '../../helper/common.dart';

class PeriodForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PeriodFormState();
  }
}

class PeriodFormState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageBloc, ManageState>(
      listener: (context, state) {
        if (state is InsertEvent) {
          formKey.currentState.reset();
        }
      },
      child: nameForm()
    );
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Period period = Period();

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
              Common.title("Cadastrar mentruação"),
              Common.divider(),
              startField(),
              endField(),
              Common.submitter(context, "Salvar", formKey, InsertEvent(period: period)),
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
        period.start = Date.parse(inValue);
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
        period.end = Date.parse(inValue);
      },
      decoration: InputDecoration(
        hintText: Date.pattern,
        labelText: "fim",
      ),
    );
  }
}