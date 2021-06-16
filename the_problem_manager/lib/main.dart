import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/DatabaseLocalServer.dart';
import 'view/common.dart';
import 'view/loggedIn.dart';
import 'view/loggedOut.dart';

import 'controller/manage_db/manage_db_bloc.dart';
import 'controller/manage_db/manage_db_state.dart' as manage;
import 'controller/monitor_db/monitor_db_bloc.dart';
import 'controller/monitor_db/monitor_db_state.dart' as monitor;

void main() {
  runApp(MyApp());
  DatabaseLocalServer.helper.check();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPM',
      theme: ThemeData(
        primarySwatch: Common.mainColor,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MonitorBloc()),
          BlocProvider(create: (_) => ManageBloc()),
        ],
        child: LoggedInOut()
      ),
    );
  }
}

class LoggedInOut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoggedInOutState();
  }
}

class LoggedInOutState extends State<LoggedInOut> {
  int screen = 0;
  static final List<StatelessWidget> screens = [
    LoggedOut(),
    LoggedIn(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageBloc, manage.ManageState>(
      listener: listenLogin,
      child: BlocListener<MonitorBloc, monitor.MonitorState>(
        listener: listenStart,
        child: screens.elementAt(screen)
      )
    );
  }

  void listenLogin(_, state) {
    if (state is manage.LoginState && state.worked) {
      setLogin(state);
    }
  }

  void listenStart(_, state) {
    if (state is monitor.LoginState && state.user != null) {
      setLogin(state.user);
    }
  }

  void setLogin(data) {
    return setState(() {
      this.screen = 1;
    });
  }
}