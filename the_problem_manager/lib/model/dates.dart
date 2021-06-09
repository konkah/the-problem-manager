import 'package:the_problem_manager/model/DatabaseLocalServer.dart';

class Dates {
  int id = 0;
  String start;
  String end;

  Map<String, dynamic> toMap() {
    return {
      DatabaseLocalServer.datesColStart: start,
      DatabaseLocalServer.datesColEnd: end,
    };
  }

  Dates.fromMap(map) {
    this.id = map[DatabaseLocalServer.datesColId];
    this.start = map[DatabaseLocalServer.datesColStart];
    this.end = map[DatabaseLocalServer.datesColEnd];
  }

  Dates();

  @override
  String toString() {
    return "[$id] $start > $end";
  }
}
