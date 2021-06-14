import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_problem_manager/controller/remote/manage_db/manage_db_bloc.dart';
import 'package:the_problem_manager/controller/remote/manage_db/manage_db_state.dart';
import 'package:the_problem_manager/controller/remote/monitor_db/monitor_db_bloc.dart';

import 'about.dart';
import 'common.dart';
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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MonitorBloc()),
            BlocProvider(create: (_) => ManageBloc()),
          ],
          child: buildScreen(),
        )
    );
  }

  Scaffold buildScreen() {
    return Scaffold(
      body: BlocListener<ManageBloc, ManageState>(
        listener: (context, state) {
          if (state is InsertState) {
            Common.showMessage(context, state.message);
            DefaultTabController.of(context).animateTo(3);
          } else if (state is DeleteState) {
            Common.showMessage(context, state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              RegistrationForm(),
              RegistrationForm(),
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