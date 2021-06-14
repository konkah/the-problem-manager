import 'package:the_problem_manager/model/period.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  int id;
  DeleteEvent({this.id});
}

class InsertEvent extends ManageEvent {
  Period period;
  InsertEvent({this.period});
}
