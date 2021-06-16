import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../model/DatabaseLocalServer.dart';
import '../../model/DatabaseRemoteServer.dart';
import '../../model/period.dart';
import '../../model/user.dart';

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