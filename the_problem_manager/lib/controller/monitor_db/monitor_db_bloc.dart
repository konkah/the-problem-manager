import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:the_problem_manager/controller/monitor_db/monitor_db_event.dart';
import 'package:the_problem_manager/controller/monitor_db/monitor_db_state.dart';
import 'package:the_problem_manager/model/DatabaseHelper.dart';
import 'package:the_problem_manager/model/dates.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _subscription;

  MonitorBloc() : super(MonitorState(datesList: [])) {
    add(AskNewList());

    _subscription =
      DatabaseHelper.helper.stream.listen((response) {
        List<Dates> datesList = response;
        add(UpdateList(datesList: datesList));
      });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var response = await DatabaseHelper.helper.getDatesList();
      List<Dates> datesList = response;
      yield MonitorState(datesList: datesList);
    } else if (event is UpdateList) {
      yield MonitorState(datesList: event.datesList);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}