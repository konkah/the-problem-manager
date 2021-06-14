import 'package:bloc/bloc.dart';
import 'package:the_problem_manager/model/DatabaseLocalServer.dart';

import 'manage_db_event.dart';
import 'manage_db_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState>{
  ManageBloc() : super(ManageState(message: ""));

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    var db = DatabaseLocalServer.helper;

    if (event is InsertEvent) {
      await db.insertPeriod(event.period);
      yield InsertState();
    } else if (event is DeleteEvent) {
      await db.deletePeriod(event.id);
      yield DeleteState();
    }
  }
}