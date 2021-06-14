import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:the_problem_manager/model/DatabaseRemoteServer.dart';
import 'package:the_problem_manager/model/period.dart';

import 'monitor_db_event.dart';
import 'monitor_db_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _subscription;

  MonitorBloc() : super(MonitorState(periodList: [])) {
    add(AskNewList());

    _subscription =
      DatabaseRemoteServer.helper.stream.listen((response) {
        List<Period> periodList = response;
        add(UpdateList(periodList: periodList));
      });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var response = await DatabaseRemoteServer.helper.getPeriodList();
      List<Period> periodList = response;
      yield MonitorState(periodList: periodList);
    } else if (event is UpdateList) {
      yield MonitorState(periodList: event.periodList);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}