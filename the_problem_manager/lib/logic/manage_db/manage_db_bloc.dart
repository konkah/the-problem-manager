import 'package:bloc/bloc.dart';
import 'package:the_problem_manager/model/DatabaseHelper.dart';

import 'manage_db_event.dart';
import 'manage_db_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState>{
  ManageBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    var db = DatabaseHelper.helper;

    if (event is DeleteEvent) {
      db.deleteDates(event.id);
    } else if (event is SubmitEvent) {
      if (state is InsertState) {
        db.insertDates(event.dates);
      }
    }
  }

}