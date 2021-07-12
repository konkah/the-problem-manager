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
      DatabaseRemoteServer.api.stream.listen((response) {
        List<Period> periodList = response;
        add(UpdateListEvent(periodList: periodList));
      });

    _subscriptionLocal =
      DatabaseLocalServer.db.stream.listen((response) {
        User user = response;
        add(StartAuthEvent(user: user));
      });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is StartAuthEvent) {
      yield StartAuthState(user: event.user);
      yield await mapToNewPeriodListState();
    }

    if (event is UpdateListEvent) {
      yield mapToPeriodListState(event);
    }

    if (event is AskNewListEvent) {
      yield await mapToNewPeriodListState();
    }
  }

  PeriodListState mapToPeriodListState(UpdateListEvent event){
    return PeriodListState(periodList: event.periodList);
  }

  Future mapToNewPeriodListState() async {
    var response = await DatabaseRemoteServer.api.getPeriodList();
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