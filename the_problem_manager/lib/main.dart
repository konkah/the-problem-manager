import 'package:flutter/material.dart';
import 'package:the_problem_manager/view/common.dart';
import 'package:the_problem_manager/view/loggedOut.dart';

import 'view/loggedIn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPM',
      theme: ThemeData(
        primarySwatch: Common.mainColor,
      ),
      home: LoggedOut(),
    );
  }
}
