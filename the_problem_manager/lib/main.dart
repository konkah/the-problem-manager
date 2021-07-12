import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/DatabaseLocalServer.dart';
import 'helper/common.dart';
import 'controller/manage_db/manage_db_bloc.dart';
import 'controller/monitor_db/monitor_db_bloc.dart';
import 'view/authWidget.dart';

void main() {
  runApp(MyApp());
  DatabaseLocalServer.db.check();
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
        child: AuthWidget()
      ),
    );
  }
}