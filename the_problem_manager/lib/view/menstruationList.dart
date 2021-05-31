import 'package:flutter/material.dart';

class MenstruationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Menstruações"),
          table(),
        ],
      ),
    );
  }

  Widget table() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text("início"),
        ),
        DataColumn(
          label: Text("fim"),
        ),
      ],
      rows: [
        DataRow(cells: [
          DataCell(date(DateTime(2021, 4, 1))),
          DataCell(date(DateTime(2021, 4, 7))),
        ]),
        DataRow(cells: [
          DataCell(date(DateTime(2021, 3, 1))),
          DataCell(date(DateTime(2021, 3, 7))),
        ]),
        DataRow(cells: [
          DataCell(date(DateTime(2021, 2, 1))),
          DataCell(date(DateTime(2021, 2, 7))),
        ]),
        DataRow(cells: [
          DataCell(date(DateTime(2021, 1, 1))),
          DataCell(date(DateTime(2021, 1, 7))),
        ]),
      ],
    );
  }

  Widget date(DateTime date) {
    return Text("${date.year}-${date.month}-${date.day}");
  }
}