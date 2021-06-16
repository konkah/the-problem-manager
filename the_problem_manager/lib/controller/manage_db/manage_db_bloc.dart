import 'package:bloc/bloc.dart';
import 'package:the_problem_manager/model/DatabaseRemoteServer.dart';

import 'manage_db_event.dart';
import 'manage_db_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState>{
  ManageBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    var db = DatabaseRemoteServer.helper;

    if (event is InsertEvent) {
      var error = await db.insertPeriod(event.period);
      if (error == null)
        yield InsertState();
      else
        yield ErrorState(error);

    } else if (event is DeleteEvent) {
      var error = await db.deletePeriod(event.id);

      if (error == null)
        yield DeleteState();
      else
        yield ErrorState(error);

    } else if (event is RegistrationEvent) {
      bool registered = await db.register(event.registration);
      yield LoginState(worked: registered);

    } else if (event is LoginEvent) {
      bool loggedIn = await db.login(event.user);
      yield LoginState(worked: loggedIn);
    }
  }
}