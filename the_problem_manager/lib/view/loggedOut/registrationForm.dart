import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/manage_db/manage_db_bloc.dart';
import '../../controller/manage_db/manage_db_state.dart';
import '../../controller/manage_db/manage_db_event.dart';
import '../../model/registration.dart';
import '../../helper/common.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageBloc, ManageState>(
      listener: (context, state) {
        if (state is LoginEvent) {
          formKey.currentState.reset();
        }
      },
      child: nameForm()
    );
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
            Common.title("Cadastro"),
            Common.divider(),
            yourNameField(),
            emailField(),
            passwordField(),
            retypePasswordField(),
            Common.dividerTransparent(),
            Common.title("Quem menstrua?"),
            Common.divider(),
            personOptions(),
            Common.submitter(
                context, "cadastrar", formKey,
                RegistrationEvent(registration: registration),
            ),
          ],
        ),
      ),
    );
  }

  Widget yourNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      validator: Common.mandatory,
      onSaved: (String inValue) {
        registration.name = inValue;
      },
      decoration: InputDecoration(
        hintText: "Nome completo ou primeiro nome",
        labelText: "Qual o seu nome?",
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
        Text("Eu"),
        personOption(false),
        Text("Outra pessoa"),
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
          return "campo obrigat??rio";
        }
        return null;
      },
      onSaved: (String inValue) {
        registration.personName =
          registration.samePerson ? null : inValue;
      },
      decoration: InputDecoration(
        hintText: "quem voc?? vai presentear com chocolate?",
        labelText: "nome da pessoa",
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: Common.mandatory,
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
      validator: Common.mandatory,
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
}