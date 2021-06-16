import '../../model/period.dart';
import '../../model/user.dart';

abstract class MonitorState {}

class PeriodListState extends MonitorState {
  List<Period> periodList;
  PeriodListState({this.periodList});
}

class LoginState extends MonitorState {
  User user;
  LoginState({this.user});
}