import '../../model/period.dart';
import '../../model/user.dart';

abstract class MonitorEvent {}

class AskNewListEvent extends MonitorEvent {}

class UpdateListEvent extends MonitorEvent {
  List<Period> periodList;
  UpdateListEvent({this.periodList});
}

class LoginEvent extends MonitorEvent {
  User user;
  LoginEvent({this.user});
}