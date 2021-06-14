import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:the_problem_manager/model/period.dart';

class DatabaseRemoteServer {
  static DatabaseRemoteServer helper = DatabaseRemoteServer._createInstance();
  DatabaseRemoteServer._createInstance();

  static String _databaseUrl = "http://192.168.0.16:8000/";
  static String _periodUrl = _databaseUrl + Period.label + "/";

  Dio _dio = Dio();

  Future<List<Period>> getPeriodList() async {
    Response response = await _dio.get(
      _periodUrl,
      options: Options(
        headers: {"Accept": "application/json"}
      )
    );

    List<Period> periodList = [];

    response.data.forEach(
        (e) => periodList.add(Period.fromMap(e))
    );

    return periodList;
  }

  Future<int> insertPeriod(Period model) async {
    Response response = await _dio.post(
      _periodUrl,
      options: Options(
          headers: {"Accept": "application/json"}
      ),
      data: jsonEncode(model.toMap())
    );

    notify();

    return response.data["id"];
  }

  Future<int> deletePeriod(int id) async {
    await _dio.delete(
      _periodUrl + "$id/",
      options: Options(
          headers: {"Accept": "application/json"}
      )
    );

    notify();

    return id;
  }

  static StreamController _controller;
  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();

      Socket socket = io(
        _databaseUrl,
        OptionBuilder()
          .setTransports(['websocket'])
          .build()
      );

      socket.on("invalidate", (data) => notify());
    }

    return _controller.stream.asBroadcastStream();
  }

  notify() async {
    if (_controller != null) {
      var list = await getPeriodList();
      _controller.sink.add(list);
    }
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }
}
