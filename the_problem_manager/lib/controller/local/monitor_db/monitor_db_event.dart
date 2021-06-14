import 'package:the_problem_manager/model/period.dart';

abstract class MonitorEvent {}

class AskNewList extends MonitorEvent {}

class UpdateList extends MonitorEvent {
  List<Period> periodList;
  UpdateList({this.periodList});
}