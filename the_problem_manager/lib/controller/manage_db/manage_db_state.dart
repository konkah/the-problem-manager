import '../../model/user.dart';

class ManageState {
  String message;
  ManageState({this.message});
}

class LoginState extends ManageState {
  User user;
  LoginState({this.user}) : super(message: "Dados inconsistentes");
}

class InsertState extends ManageState {
  InsertState() : super(message: "Dados inseridos com sucesso!");
}

class DeleteState extends ManageState {
  DeleteState() : super(message: "Dados removidos com sucesso!");
}

class ErrorState extends ManageState {
  ErrorState(String message) : super(message: message);
}