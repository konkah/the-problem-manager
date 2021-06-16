import 'package:intl/intl.dart';

class Date {
  static String _pattern = 'dd/MM/yyyy';
  static DateFormat _format = DateFormat(_pattern);
  static String format(DateTime value) {
    return _format.format(value);
  }
  static DateTime parse(String value) {
    return _format.parse(value);
  }

  static DateFormat _universalFormat = DateFormat('yyyy-MM-dd');
  static String toUniversal(DateTime value) {
    return _universalFormat.format(value);
  }
  static DateTime fromUniversal(String value) {
    return _universalFormat.parse(value);
  }

  static String pattern = _pattern.toUpperCase();

  static DateTime today() {
    return justDay(DateTime.now());
  }

  static DateTime justDay(DateTime origin) {
    return origin.subtract(Duration(
        days: 0,
        hours: origin.hour,
        minutes: origin.minute,
        seconds: origin.second,
        milliseconds: origin.millisecond,
        microseconds: origin.microsecond
    ));
  }

  static DateTime first(DateTime a, DateTime b) {
    return a.isBefore(b) ? a : b;
  }

  static final List<String> months =
  [
    "Janeiro" , "Fevereiro", "Março"  , "Abril"   ,
    "Maio"    , "Junho"    , "Julho"  , "Agosto"  ,
    "Setembro", "Outubro"  , "Nomebro", "Dezembro",
  ];

  static String month(DateTime date) {
    return '${months[date.month - 1]} / ${date.year}';
  }

  static DateTime weekStart(DateTime date) {
    return date.subtract(
        Duration(days: date.weekday - 1)
    );
  }

  static DateTime weekEnd(DateTime date) {
    return date.add(
      Duration(
        days: 6 - date.weekday + 1,
        hours: 23,
      )
    );
  }

  static bool between(DateTime date, DateTime start, DateTime end) {
    bool isEdge = date == start || date == end;

    bool isInside = date.isAfter(start)
        && date.isBefore(end);

    return isInside || isEdge;
  }
}