import 'package:the_problem_manager/model/DatabaseLocalServer.dart';

class Names {
  int id = 0;
  String yourName = "";
  String personName = "";
  bool samePerson = false;

  Map<String, Object> toMap() {
    return {
      DatabaseLocalServer.namesColYourName: yourName,
      DatabaseLocalServer.namesColPersonName: personName,
      DatabaseLocalServer.namesColSamePerson: samePerson,
    };
  }

  Names.fromMap(map) {
    this.id = map[DatabaseLocalServer.namesColId];
    this.yourName = map[DatabaseLocalServer.namesColYourName];
    this.personName = map[DatabaseLocalServer.namesColPersonName];
    this.samePerson = map[DatabaseLocalServer.namesColSamePerson];
  }

  Names();
}
