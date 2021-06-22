import 'package:bloc/bloc.dart';

import '../../model/user.dart';
import '../../model/DatabaseRemoteServer.dart';
import '../../model/DatabaseLocalServer.dart';

import 'manage_db_event.dart';
import 'manage_db_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState>{
  ManageBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    var api = DatabaseRemoteServer.api;
    var db = DatabaseLocalServer.db;

    String error;

    if (event is RegistrationEvent) {
      error = await api.register(event.registration);
      if (error == null)
        yield LoginState(user: User.fromRegistration(event.registration));
    }

    if (event is LoginEvent) {
      error = await api.login(event.user);
      if (error == null)
        yield LoginState(user: event.user);
    }

    if (event is LogoutEvent) {
      await db.delete();
      yield LogoutState();
    }

    if (event is InsertEvent) {
      error = await api.insertPeriod(event.period);
      if (error == null)
        yield InsertState();
    }

    if (event is DeleteEvent) {
      String error = await api.deletePeriod(event.id);
      if (error == null)
        yield DeleteState();
    }

    if (error != null)
      yield ErrorState(error);
  }
}