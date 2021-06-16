import '../../model/period.dart';
import '../../model/registration.dart';
import '../../model/user.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  int id;
  DeleteEvent({this.id});
}

class InsertEvent extends ManageEvent {
  Period period;
  InsertEvent({this.period});
}

class RegistrationEvent extends ManageEvent {
  Registration registration;
  RegistrationEvent({this.registration});
}

class LoginEvent extends ManageEvent {
  User user;
  LoginEvent({this.user});
}
