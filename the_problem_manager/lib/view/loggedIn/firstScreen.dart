import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/monitor_db/monitor_db_bloc.dart';
import '../../controller/monitor_db/monitor_db_state.dart';

import '../common.dart';
import 'calendar.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Common.title("Próxima TPM Prevista"),
          Common.divider(),
          BlocBuilder<MonitorBloc, MonitorState>(
            builder: (context, state) {
              return Calendar(state);
            },
          ),
        ],
      ),
    );
  }
}
