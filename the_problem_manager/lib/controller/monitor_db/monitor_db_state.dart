import 'package:the_problem_manager/model/period.dart';
import 'package:the_problem_manager/model/user.dart';

abstract class MonitorState {}

class PeriodListState extends MonitorState {
  List<Period> periodList;
  PeriodListState({this.periodList});
}

class LoginState extends MonitorState {
  User user;
  LoginState({this.user});
}