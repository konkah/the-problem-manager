import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:the_problem_manager/model/DatabaseLocalServer.dart';
import 'package:the_problem_manager/model/DatabaseRemoteServer.dart';
import 'package:the_problem_manager/model/period.dart';
import 'package:the_problem_manager/model/user.dart';

import 'monitor_db_event.dart';
import 'monitor_db_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _subscriptionRemote;
  StreamSubscription _subscriptionLocal;

  MonitorBloc() : super(PeriodListState()) {
    add(AskNewListEvent());

    _subscriptionRemote =
      DatabaseRemoteServer.helper.stream.listen((response) {
        List<Period> periodList = response;
        add(UpdateListEvent(periodList: periodList));
      });

    _subscriptionLocal =
      DatabaseLocalServer.helper.stream.listen((response) {
        User user = response;
        add(LoginEvent(user: user));
      });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is UpdateListEvent) {
      yield PeriodListState(periodList: event.periodList);
    } else if (event is AskNewListEvent) {
      yield await getNewList();
    } else if (event is LoginEvent) {
      print(1);
      yield LoginState(user: event.user);
      yield await getNewList();
    }
  }

  Future<PeriodListState> getNewList() async {
    var response = await DatabaseRemoteServer.helper.getPeriodList();
    List<Period> periodList = response;
    return PeriodListState(periodList: periodList);
  }

  @override
  Future<void> close() {
    _subscriptionRemote.cancel();
    _subscriptionLocal.cancel();
    return super.close();
  }
}