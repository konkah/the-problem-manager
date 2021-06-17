import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'DatabaseLocalServer.dart';
import 'registration.dart';
import 'period.dart';

import 'user.dart';

class DatabaseRemoteServer {
  static DatabaseRemoteServer helper = DatabaseRemoteServer._createInstance();
  DatabaseRemoteServer._createInstance();

  static String _databaseUrl = "http://192.168.0.13:8000/";
  static String _periodUrl = _databaseUrl + Period.label + "/";
  static String _registrationUrl = _databaseUrl + Registration.label + "/";

  Dio _dio = Dio();

  Future<List<Period>> getPeriodList() async {
    Response response = await _dio.get(
      _periodUrl,
      options: await options()
    );

    List<Period> periodList = [];

    if (response.statusCode == 200) {
      response.data.forEach(
        (e) => periodList.add(Period.fromMap(e))
      );
    } else {
      print(response.data);
    }

    return periodList;
  }

  Future<String> insertPeriod(Period model) async {
    User user = await DatabaseLocalServer.helper.get();

    Response response = await _dio.post(
      _periodUrl,
      options: await options(),
      data: jsonEncode(model.toMap(user.registration))
    );

    if (response.statusCode < 400) {
      notify();
      return null;
    }

    return response.data.toString();
  }

  Future<String> deletePeriod(int id) async {
    var response = await _dio.delete(
      _periodUrl + "$id/",
      options: await options()
    );

    if (response.statusCode < 400) {
      notify();
      return null;
    }

    return response.data.toString();
  }

  Future<String> register(Registration registration) async {
    Response response = await _dio.post(
        _registrationUrl,
        options: await options(),
        data: jsonEncode(registration.toMap())
    );

    if (response.statusCode < 400) {
      registration.id = response.data;
      _recordLogin(
        User.fromRegistration(registration)
      );
      return null;
    }

    return response.data.toString();
  }

  Future<String> login(User user) async {
    Response response = await _dio.get(
        _registrationUrl + "/test",
        options: await optionsByUser(user),
    );

    if (response.statusCode < 400) {
      _recordLogin(user);
      return null;
    }

    return response.data.toString();
  }

  Future<void> _recordLogin(User user) async {
    await DatabaseLocalServer.helper.set(user);
  }

  Future<Options> options() async {
    User user = await DatabaseLocalServer.helper.get();
    return await optionsByUser(user);
  }

  Future<Options> optionsByUser(User user) async {
    Map<String, dynamic> headers = {
      "Accept": "application/json"
    };

    if (user != null) {
      var auth = '${user.email}:${user.password}';
      var encoded = base64Encode(utf8.encode(auth));
      headers["authorization"] = 'Basic $encoded';
    }

    return Options(
      headers: headers,

      followRedirects: true,
      validateStatus: (s) => s < 500,
    );
  }

  static StreamController _controller;
  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
      /*
      Socket socket = io(
        _databaseUrl,
        OptionBuilder()
          .setTransports(['websocket'])
          .build()
      );

      socket.on("invalidate", (data) => notify());
      */
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
