import '../model/period.dart';

class TPM {
  bool canCalculate = false;
  DateTime start;
  DateTime end;

  TPM(List<Period> periodList) {
    if (periodList.length < 2)
      return;

    int sum = 0;
    DateTime compare = periodList[0].start;

    for(var period in periodList.skip(1)) {
      Duration diff = compare.difference(period.start);
      sum += diff.inDays;
      compare = period.start;
    }

    int countDiffs = periodList.length - 1;
    int average = (sum / countDiffs).truncate();

    DateTime last = periodList[0].start;

    do {
      last = last.add(Duration(days: average));
    } while (last.isBefore(DateTime.now()));

    this.canCalculate = true;
    this.start = last.subtract(Duration(days: 14));
    this.end = last;
  }
}
