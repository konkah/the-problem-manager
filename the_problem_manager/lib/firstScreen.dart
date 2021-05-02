import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title(),
        calendar(),
      ],
    );
  }

  Widget title() {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
            "Próxima TPM Prevista",
            style: TextStyle(
              fontSize: 24,
              color: Colors.redAccent,
              fontStyle: FontStyle.italic,
            ),
        ),
      );
  }

  Widget calendar() {
    return CalendarDatePicker(
      initialDate: DateTime(2021, 5, 17),
      firstDate: DateTime(2021, 5, 1),
      lastDate: DateTime(2021, 5, 31),
      onDateChanged: (DateTime date) {

      },
      selectableDayPredicate: (DateTime date) {
        return date == DateTime(2021, 5, 17);
      },
    );
  }
}