import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_problem_manager/model/period.dart';

class DatabaseLocalServer {
  static DatabaseLocalServer helper = DatabaseLocalServer._createInstance();
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
    String path = dir.path + "tpm.db";
    var tpmDB = await openDatabase(
        path,
        version: 1,
        onCreate: _createDb
    );
    return tpmDB;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE ${Period.label} ("
            "${Period.propId} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${Period.propStart} DATE, "
            "${Period.propEnd} DATE"
        ")"
    );
  }

  Future<List<Period>> getPeriodList() async {
    Database db = await this.database;

    var periodMapList = await db.query(Period.label);

    return periodMapList.map((e) => Period.fromMap(e)).toList();
  }

  Future<int> insertPeriod(Period model) async {
    Database db = await this.database;

    var id = await db.insert(Period.label, model.toMap());

    notify();

    return id;
  }

  Future<int> deletePeriod(int id) async {
    Database db = await this.database;

    var result = await db.delete(
        Period.label,
        where: "${Period.propId} = ?",
        whereArgs: [id]
    );

    notify();

    return result;
  }

  static StreamController _controller;
  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
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