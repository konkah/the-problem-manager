import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'user.dart';

class DatabaseLocalServer {
  static DatabaseLocalServer db = DatabaseLocalServer._createInstance();
  DatabaseLocalServer._createInstance();

  static Database _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }

    return _database;
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "/tpm.db";
    var tpmDB = await openDatabase(
        path,
        version: 2,
        onCreate: _createDb
    );
    return tpmDB;
  }

  void _createDb(Database db, int newVersion) async {
    String query = "CREATE TABLE ${User.label} ("
      "${User.propEmail} TEXT, "
      "${User.propPassword} TEXT, "
      "${User.propRegistration} INT"
    ")";

    await db.execute(query);
  }

  Future<User> get() async {
    Database db = await this.database;

    var mapList = await db.query(User.label);

    if (mapList.isEmpty)
      return null;

    User user = User.fromMap(mapList[0]);

    return user;
  }

  Future<void> check() async {
    User user = await this.get();
    if (user != null)
      notify(user);
  }

  Future<void> set(User model) async {
    Database db = await this.database;

    await db.delete(
        User.label,
        where: '${User.propEmail} = ?', whereArgs: [model.email]
    );
    await db.insert(User.label, model.toMap());
  }

  static StreamController _controller;
  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
    }

    return _controller.stream.asBroadcastStream();
  }

  notify(User user) async {
    if (_controller != null) {
      _controller.sink.add(user);
    }
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }
}