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
}