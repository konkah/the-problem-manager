import 'package:flutter/material.dart';
import '../view/common.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Common.title("Próxima TPM Prevista"),
          Common.divider(),
          calendar(),
        ],
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