import 'package:the_problem_manager/helper/date.dart';
import 'package:the_problem_manager/model/DatabaseLocalServer.dart';

class Dates {
  int id = 0;
  DateTime start;
  DateTime end;

  Map<String, dynamic> toMap() {
    return {
      DatabaseLocalServer.datesColStart: Date.toUniversal(start),
      DatabaseLocalServer.datesColEnd: Date.toUniversal(end),
    };
  }

  Dates.fromMap(map) {
    this.id = map[DatabaseLocalServer.datesColId];
    this.start = Date.fromUniversal(
      map[DatabaseLocalServer.datesColStart]
    );
    this.end = Date.fromUniversal(
      map[DatabaseLocalServer.datesColEnd]
    );
  }

  Dates();

  @override
  String toString() {
    return "[$id] $start > $end";
  }
}
