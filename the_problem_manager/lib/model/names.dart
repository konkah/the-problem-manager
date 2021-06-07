import 'package:the_problem_manager/model/DatabaseHelper.dart';

class Names {
  int id = 0;
  String yourName = "";
  String personName = "";
  bool samePerson = false;

  Map<String, Object> toMap() {
    return {
      DatabaseHelper.namesColYourName: yourName,
      DatabaseHelper.namesColPersonName: personName,
      DatabaseHelper.namesColSamePerson: samePerson,
    };
  }

  Names.fromMap(map) {
    this.id = map[DatabaseHelper.namesColId];
    this.yourName = map[DatabaseHelper.namesColYourName];
    this.personName = map[DatabaseHelper.namesColPersonName];
    this.samePerson = map[DatabaseHelper.namesColSamePerson];
  }

  Names();
}
