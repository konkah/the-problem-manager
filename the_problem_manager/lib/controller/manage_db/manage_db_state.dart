import '../../model/user.dart';

class ManageState {
  dynamic message;
  ManageState({this.message});
}

class LoginState extends ManageState {
  User user;
  LoginState({this.user}) : super(message: "Dados inconsistentes");
}

class LogoutState extends ManageState {
  LogoutState() : super(message: "Até logo!");
}

class InsertState extends ManageState {
  InsertState() : super(message: "Dados inseridos com sucesso!");
}

class DeleteState extends ManageState {
  DeleteState() : super(message: "Dados removidos com sucesso!");
}

class ErrorState extends ManageState {
  ErrorState(dynamic message) : super(message: message);
}