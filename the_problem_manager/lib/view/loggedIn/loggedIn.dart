import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/monitor_db/monitor_db_bloc.dart';
import '../../controller/monitor_db/monitor_db_event.dart';
import '../../controller/manage_db/manage_db_event.dart';
import '../../controller/manage_db/manage_db_bloc.dart';
import '../../controller/manage_db/manage_db_state.dart';

import '../about.dart';
import '../../helper/common.dart';
import 'firstScreen.dart';
import 'periodForm.dart';
import 'periodList.dart';

class LoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildTabController(context);
  }

  DefaultTabController buildTabController(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: buildScreen(context),
    );
  }

  Scaffold buildScreen(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ManageBloc>(context)
              .add(LogoutEvent());
          BlocProvider.of<MonitorBloc>(context)
              .add(AskNewListEvent());
        },
        tooltip: "Sair",
        child: Icon(Icons.logout),
      ),
      body: BlocListener<ManageBloc, ManageState>(
        listener: (context, state) {
          if (state is InsertState) {
            Common.showMessage(context, state.message);
            DefaultTabController.of(context).animateTo(1);
          }

          if (state is DeleteState) {
            Common.showMessage(context, state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              FirstScreen(),
              PeriodList(),
              PeriodForm(),
              About(),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("The Problem Manager"),
        bottom: TabBar(tabs: [
          Tab(icon: Icon(Icons.calendar_today)),
          Tab(icon: Icon(Icons.list)),
          Tab(icon: Icon(Icons.add_box_rounded)),
          Tab(icon: Icon(Icons.report_rounded))
        ]),
      ),
    );
  }
}