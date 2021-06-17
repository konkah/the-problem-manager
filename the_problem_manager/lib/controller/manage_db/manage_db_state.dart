class ManageState {
  String message;
  ManageState({this.message});
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

class LoginState extends ManageState {
  bool worked;
  String email;
  String password;
  LoginState({this.worked, this.email, this.password}) : super(message: "Dados inconsistentes");
}
