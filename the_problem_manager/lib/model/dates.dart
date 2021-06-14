import 'package:the_problem_manager/helper/date.dart';

class Dates {
  int id = 0;
  DateTime start;
  DateTime end;

  Map<String, dynamic> toMap() {
    return {
      propStart: Date.toUniversal(start),
      propEnd: Date.toUniversal(end),
    };
  }

  Dates.fromMap(map) {
    this.id = map[propId];
    this.start = Date.fromUniversal(map[propStart]);
    this.end = Date.fromUniversal(map[propEnd]);
  }

  Dates();

  @override
  String toString() {
    return "[$id] $start > $end";
  }

  static String label = "dates";
  static String propId = "id";
  static String propStart = "start";
  static String propEnd = "end";
}
