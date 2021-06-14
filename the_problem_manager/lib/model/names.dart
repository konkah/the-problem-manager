import 'package:the_problem_manager/model/DatabaseLocalServer.dart';

class Names {
  int id = 0;
  String yourName = "";
  String personName = "";
  bool samePerson = false;

  Map<String, Object> toMap() {
    return {
      propYourName: yourName,
      propPersonName: personName,
      propSamePerson: samePerson,
    };
  }

  Names.fromMap(map) {
    this.id = map[propId];
    this.yourName = map[propYourName];
    this.personName = map[propPersonName];
    this.samePerson = map[propSamePerson];
  }

  Names();

  static String label = "names";
  static String propId = "id";
  static String propYourName = "yourName";
  static String propPersonName = "personName";
  static String propSamePerson = "samePerson";
}
