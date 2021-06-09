import 'package:the_problem_manager/model/dates.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  int id;
  DeleteEvent({this.id});
}

class InsertEvent extends ManageEvent {
  Dates dates;
  InsertEvent({this.dates});
}
