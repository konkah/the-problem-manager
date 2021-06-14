import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_problem_manager/model/dates.dart';

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
        "CREATE TABLE ${Dates.label} ("
            "${Dates.propId} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${Dates.propStart} DATE, "
            "${Dates.propEnd} DATE"
        ")"
    );
  }

  Future<List<Dates>> getDatesList() async {
    Database db = await this.database;

    var datesMapList = await db.query(Dates.label);

    return datesMapList.map((e) => Dates.fromMap(e)).toList();
  }

  Future<int> insertDates(Dates model) async {
    Database db = await this.database;

    var id = await db.insert(Dates.label, model.toMap());

    notify();

    return id;
  }

  Future<int> updateDates(Dates model) async {
    Database db = await this.database;

    var id = await db.update(
        Dates.label,
        model.toMap(),
        where: "${Dates.propId} = ?",
        whereArgs: [model.id]
    );

    notify();

    return id;
  }

  Future<int> deleteDates(int id) async {
    Database db = await this.database;

    var result = await db.delete(
        Dates.label,
        where: "${Dates.propId} = ?",
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