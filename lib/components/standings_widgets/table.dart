import 'package:flutter/material.dart';

class ConfTable extends StatefulWidget {
  final dynamic json;
  final Map teamIds;
  const ConfTable({super.key, this.json, required this.teamIds});
  @override
  State<ConfTable> createState() => _ConfTableState();
}

class _ConfTableState extends State<ConfTable> {
  List<DataRow> tableData() {
    List<DataRow> table = <DataRow>[
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
      const DataRow(cells: []),
    ]; // fixed table length of 15 teams
    for (int index = 0; index < widget.teamIds.length; index++) {
      int rank = widget.json["response"][index]["conference"]['rank'];
      int pos = rank - 1;
      table[pos] = (DataRow(
        cells: [
          DataCell(
            Text(
              "$rank ${widget.json["response"][index]["team"]['name']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataCell(
            Text("${widget.json["response"][index]["win"]['total']}"), //
          ),
          DataCell(
            Text("${widget.json["response"][index]["loss"]['total']}"),
          ),
          DataCell(
            Text("${widget.json["response"][index]["win"]['percentage']}"),
          ),
        ],
      ));
    }
    return table;
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
          label: Text(
            'Team',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'W',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'L',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Pct',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
        ),
      ],
      rows: tableData(),
    );
  }
}
