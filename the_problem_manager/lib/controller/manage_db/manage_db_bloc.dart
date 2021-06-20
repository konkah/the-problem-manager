import 'package:bloc/bloc.dart';

import '../../model/user.dart';
import '../../model/DatabaseRemoteServer.dart';

import 'manage_db_event.dart';
import 'manage_db_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState>{
  ManageBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    var db = DatabaseRemoteServer.api;

    String error;

    if (event is RegistrationEvent) {
      error = await db.register(event.registration);
      if (error == null)
        yield LoginState(user: User.fromRegistration(event.registration));
    }

    if (event is LoginEvent) {
      error = await db.login(event.user);
      if (error == null)
        yield LoginState(user: event.user);
    }

    if (event is InsertEvent) {
      error = await db.insertPeriod(event.period);
      if (error == null)
        yield InsertState();
    }

    if (event is DeleteEvent) {
      String error = await db.deletePeriod(event.id);
      if (error == null)
        yield DeleteState();
    }

    if (error != null)
      yield ErrorState(error);
  }
}