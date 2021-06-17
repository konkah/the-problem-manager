import '../../model/period.dart';
import '../../model/user.dart';

abstract class MonitorState {}

class StartAuthState extends MonitorState {
  User user;
  StartAuthState({this.user});
}

class PeriodListState extends MonitorState {
  List<Period> periodList;
  PeriodListState({this.periodList});
}
