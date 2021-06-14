import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:the_problem_manager/model/dates.dart';

class DatabaseRemoteServer {
  static DatabaseRemoteServer helper = DatabaseRemoteServer._createInstance();
  DatabaseRemoteServer._createInstance();

  static String _databaseUrl = "http://192.168.0.16:8000/";
  static String _datesUrl = _databaseUrl + Dates.label + "/";

  Dio _dio = Dio();

  Future<List<Dates>> getDatesList() async {
    Response response = await _dio.get(
      _datesUrl,
      options: Options(
        headers: {"Accept": "application/json"}
      )
    );

    List<Dates> datesList = [];

    response.data.forEach(
        (e) => datesList.add(Dates.fromMap(e))
    );

    return datesList;
  }

  Future<int> insertDates(Dates model) async {
    Response response = await _dio.post(
      _datesUrl,
      options: Options(
          headers: {"Accept": "application/json"}
      ),
      data: jsonEncode(model.toMap())
    );

    notify();

    return response.data["id"];
  }

  Future<int> updateDates(Dates model) async {
    Response response = await _dio.put(
      _datesUrl + "${model.id}/",
      options: Options(
          headers: {"Accept": "application/json"}
      ),
      data: jsonEncode(model.toMap())
    );

    notify();

    return response.data["id"];
  }

  Future<int> deleteDates(int id) async {
    await _dio.delete(
      _datesUrl + "$id/",
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
      var list = await getDatesList();
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
