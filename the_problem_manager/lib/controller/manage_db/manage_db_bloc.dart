import 'package:bloc/bloc.dart';
import 'package:the_problem_manager/model/DatabaseHelper.dart';

import 'manage_db_event.dart';
import 'manage_db_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState>{
  ManageBloc() : super(ManageState(message: ""));

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    var db = DatabaseHelper.helper;

    if (event is InsertEvent) {
      db.insertDates(event.dates);
      yield InsertState();
    } else if (event is DeleteEvent) {
      db.deleteDates(event.id);
      yield DeleteState();
    }
  }
}