import '../../model/period.dart';
import '../../model/user.dart';

abstract class MonitorEvent {}

class StartAuthEvent extends MonitorEvent {
  User user;
  StartAuthEvent({this.user});
}

class AskNewListEvent extends MonitorEvent {}

class UpdateListEvent extends MonitorEvent {
  List<Period> periodList;
  UpdateListEvent({this.periodList});
}
