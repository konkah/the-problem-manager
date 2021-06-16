import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/manage_db/manage_db_bloc.dart';
import '../controller/manage_db/manage_db_state.dart';

import 'about.dart';
import 'common.dart';
import 'loginForm.dart';
import 'registrationForm.dart';

class LoggedOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildTabController();
  }

  DefaultTabController buildTabController() {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: buildScreen(),
    );
  }

  Scaffold buildScreen() {
    return Scaffold(
      body: BlocListener<ManageBloc, ManageState>(
        listener: (context, state) {
          if (state is LoginState) {
            if (!state.worked) {
              Common.showMessage(context, state.message);
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              RegistrationForm(),
              LoginForm(),
              About(),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("The Problem Manager"),
        bottom: TabBar(tabs: [
          Tab(icon: Icon(Icons.app_registration)),
          Tab(icon: Icon(Icons.login)),
          Tab(icon: Icon(Icons.info_outline))
        ]),
      ),
    );
  }
}