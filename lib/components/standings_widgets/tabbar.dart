import 'package:flutter/material.dart';
import 'package:court_craze/components/standings_widgets/table.dart';
import '../../constant.dart';

class Bar extends StatelessWidget {
  final dynamic eastTable;
  final dynamic westTable;
  const Bar({super.key, this.eastTable, this.westTable});
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConfTable(
            json: eastTable,
            teamIds: eastID,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConfTable(
            json: westTable,
            teamIds: westID,
          ),
        )
      ],
    );
  }
}
