import 'package:the_problem_manager/model/DatabaseHelper.dart';

class Dates {
  int id = 0;
  String start;
  String end;

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.datesColStart: start,
      DatabaseHelper.datesColEnd: end,
    };
  }

  Dates.fromMap(map) {
    this.id = map[DatabaseHelper.datesColId];
    this.start = map[DatabaseHelper.datesColStart];
    this.end = map[DatabaseHelper.datesColEnd];
  }

  Dates();

  @override
  String toString() {
    return "[$id] $start > $end";
  }
}
