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
      await db.insertPeriod(event.period);
      yield InsertState();
    } else if (event is DeleteEvent) {
      await db.deletePeriod(event.id);
      yield DeleteState();
    }
  }

}