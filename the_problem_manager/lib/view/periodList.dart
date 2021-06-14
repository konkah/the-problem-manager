import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_problem_manager/controller/remote/manage_db/manage_db_bloc.dart';
import 'package:the_problem_manager/controller/remote/manage_db/manage_db_event.dart';
import 'package:the_problem_manager/controller/remote/monitor_db/monitor_db_bloc.dart';
import 'package:the_problem_manager/controller/remote/monitor_db/monitor_db_state.dart';
import 'package:the_problem_manager/helper/date.dart';
import 'package:the_problem_manager/model/period.dart';

import 'common.dart';

class PeriodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Common.title("Menstruações"),
          Common.divider(),
          BlocBuilder<MonitorBloc, MonitorState>(
            builder: (context, state) {
              return table(context, state.periodList);
            }
          ),
        ],
      ),
    );
  }

  Widget table(BuildContext context, List<Period> periodList) {
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
        periodList.map((period) =>
          generateDataRow(period, context)
        ).toList(),
    );
  }

  DataRow generateDataRow(Period period, BuildContext context) {
    return DataRow(cells: [
      DataCell(Text(Date.format(period.start))),
      DataCell(Text(Date.format(period.end))),
      DataCell(
        Icon(Icons.delete),
        onTap: () {
          BlocProvider.of<ManageBloc>(context)
              .add(DeleteEvent(id: period.id));
        }
      ),
    ]);
  }

  Widget date(DateTime date) {
    return Text("${date.year}-${date.month}-${date.day}");
  }
}