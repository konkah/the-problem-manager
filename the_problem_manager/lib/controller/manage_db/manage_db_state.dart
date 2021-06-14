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
