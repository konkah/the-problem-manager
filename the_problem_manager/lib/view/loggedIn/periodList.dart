import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/manage_db/manage_db_bloc.dart';
import '../../controller/manage_db/manage_db_event.dart';
import '../../controller/monitor_db/monitor_db_bloc.dart';
import '../../controller/monitor_db/monitor_db_state.dart';
import '../../helper/date.dart';
import '../../model/period.dart';

import '../../helper/common.dart';

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
              if (state is PeriodListState) {
                if (state.periodList.isNotEmpty) {
                  return buildBody(context, state);
                }
              }
              return Common.subtitle("Não há menstruações cadastradas");
            }
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context, PeriodListState state) {
    Widget list = table(context, state.periodList);

    if (state.periodList.length == 1) {
      return Column(
        children: [
          Common.subtitle("São necessárias ao menos duas menstruações para calcular a TPM"),
          list,
        ],
      );
    }

    return list;
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