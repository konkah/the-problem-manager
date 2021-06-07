import 'package:the_problem_manager/model/dates.dart';

abstract class MonitorEvent {}

class AskNewList extends MonitorEvent {}

class UpdateList extends MonitorEvent {
  List<Dates> datesList;
  UpdateList({this.datesList});
}