import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_problem_manager/controller/local/manage_db/manage_db_bloc.dart';
import 'package:the_problem_manager/controller/local/manage_db/manage_db_event.dart';
import 'package:the_problem_manager/controller/local/monitor_db/monitor_db_bloc.dart';
import 'package:the_problem_manager/controller/local/monitor_db/monitor_db_state.dart';
import 'package:the_problem_manager/model/dates.dart';

class MenstruationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Menstruações"),
          BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
            return table(context, state.datesList);
          }),
        ],
      ),
    );
  }

  Widget table(BuildContext context, List<Dates> datesList) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text("início"),
        ),
        DataColumn(
          label: Text("fim"),
        ),
        DataColumn(
          label: Text(""),
        ),
      ],
      rows:
        datesList.map((dates) =>
          generateDataRow(dates, context)
        ).toList(),
    );
  }

  DataRow generateDataRow(Dates dates, BuildContext context) {
    return DataRow(cells: [
      DataCell(Text(dates.start)),
      DataCell(Text(dates.end)),
      DataCell(
        Icon(Icons.delete),
        onTap: () {
          BlocProvider.of<ManageBloc>(context)
              .add(DeleteEvent(id: dates.id));
        }
      ),
    ]);
  }

  Widget date(DateTime date) {
    return Text("${date.year}-${date.month}-${date.day}");
  }
}