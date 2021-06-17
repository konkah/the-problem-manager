import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/manage_db/manage_db_bloc.dart';
import '../controller/manage_db/manage_db_state.dart';
import '../controller/monitor_db/monitor_db_bloc.dart';
import '../controller/monitor_db/monitor_db_state.dart';

import 'common.dart';
import 'loggedIn/loggedIn.dart';
import 'loggedOut/loggedOut.dart';

class AuthWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthWidgetState();
  }
}

class AuthWidgetState extends State<AuthWidget> {
  int screen = 0;
  static final List<StatelessWidget> screens = [
    LoggedOut(),
    LoggedIn(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageBloc, ManageState>(
        listener: listenLogin,
        child: BlocListener<MonitorBloc, MonitorState>(
            listener: listenStart,
            child: screens.elementAt(screen)
        )
    );
  }

  void listenLogin(_, state) {
    if (state is LoginState) {
      setLogin(state.user);
    }

    if (state is ErrorState) {
      Common.showMessage(context, state.message);
    }
  }

  void listenStart(_, state) {
    if (state is StartAuthState) {
      setLogin(state.user);
    }
  }

  void setLogin(user) {
    return setState(() {
      this.screen = 1;
    });
  }
}