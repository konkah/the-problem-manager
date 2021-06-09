import 'package:the_problem_manager/model/dates.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  int id;
  DeleteEvent({this.id});
}

class SubmitEvent extends ManageEvent {
  Dates dates;
  SubmitEvent({this.dates});
}
