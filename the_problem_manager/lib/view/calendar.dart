import 'package:flutter/material.dart';

import '../controller/monitor_db/monitor_db_state.dart';
import '../helper/date.dart';
import '../helper/tpm.dart';

import 'common.dart';

class Calendar extends StatelessWidget{
  final MonitorState _state;

  Calendar(this._state);

  @override
  Widget build(BuildContext context) {
    var state = this._state;

    if (state is PeriodListState) {
      TPM tpm = TPM(state.periodList);

      if (tpm.canCalculate) {
        return buildCalendar(tpm);
      }
    }

    return buildTitle("Sem dados ainda");
  }

  Widget buildCalendar(TPM tpm) {
    DateTime today = Date.today();
    DateTime start = Date.first(today, tpm.start);
    start = Date.weekStart(start);

    DateTime end = Date.weekEnd(tpm.end);
    end = end.add(Duration(days: 1));
    DateTime date = start;

    List<Widget> column = [buildMonthTitle(start)];

    List<Widget> row = [];

    do {
      if (date.weekday == DateTime.monday) {
        column.add(buildRow(row));
        row = [];
      }

      if (date.day == 1) {
        if (row.isNotEmpty) {
          for (int d = date.weekday; d <= 7; d++) {
            row.add(buildEmpty());
          }

          column.add(buildRow(row));
          row = [];

          column.add(buildMonthTitle(date));

          for (int d = 1; d < date.weekday; d++) {
            row.add(buildEmpty());
          }
        }
        else
        {
          column.add(buildMonthTitle(date));
        }
      }

      row.add(buildDay(date, today, tpm));

      date = date.add(Duration(days: 1));

    } while( date.isBefore(end) );

    column.add(Common.divider());

    return Column(children: column);
  }

  Widget buildMonthTitle(DateTime date) {
    return buildTitle(Date.month(date));
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          color: Common.tpmColor,
          fontSize: 18
        ),
      ),
    );
  }

  Widget buildDay(DateTime date, DateTime today, TPM tpm) {
    String text = date.day.toString().padLeft(2, '0');

    bool isTpm = Date.between(date, tpm.start, tpm.end);

    Color font = isTpm
        ? Colors.white : Common.mainColor;

    Color background = isTpm
        ? Common.tpmColor : Colors.transparent;

    Color border = date == today
        ? Common.mainColor : Colors.transparent;

    return buildText(text, font, background, border);
  }

  Widget buildEmpty() {
    Color noColor = Colors.transparent;
    return buildText("--", noColor, noColor, noColor);
  }

  Widget buildText(String text, Color font, Color background, Color border) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Container(
        width: 38,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: border,
            width: 3.0
          ),
          color: background,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: font,
          ),
        ),
      ),
    );
  }

  Widget buildRow(List<Widget> row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: row
    );
  }
}
