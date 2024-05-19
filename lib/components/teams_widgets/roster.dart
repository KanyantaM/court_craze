import 'package:flutter/material.dart';

class Roster extends StatelessWidget {
  final dynamic json;
  const Roster({super.key, this.json});
  List<List<DataRow>> roster() {
    List<DataRow> playerNames = [];
    List<DataRow> playerAttributes = [];
    for (int index = 0; index < json["results"]; index++) {
      dynamic base = json["response"][index];
      Map league = base["leagues"];
      if (league.length == 1 && league.keys.contains("standard")) {
        playerNames.add(
          DataRow(
            cells: [
              DataCell(
                Text(
                  "${base["firstname"]} ${base["lastname"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );

        playerAttributes.add(
          DataRow(
            cells: [
              DataCell(
                Text(
                  league["standard"]["pos"].toString().isEmpty
                      ? "-"
                      : "${league["standard"]["pos"]}",
                ),
              ),
              DataCell(
                Text(
                  league["standard"]["jersey"].toString().isEmpty
                      ? "-"
                      : "${league["standard"]["jersey"]}",
                ),
              ),
              DataCell(
                Text(
                  base["height"]['meters'].toString().isEmpty
                      ? "-"
                      : "${base["height"]['meters']}",
                ),
              ),
              DataCell(
                Text(
                  base["weight"]['kilograms'].toString().isEmpty
                      ? "-"
                      : "${base["weight"]['kilograms']}",
                ),
              ),
              DataCell(
                Text(
                  base["birth"]['date'].toString().isEmpty
                      ? "-"
                      : "${base["birth"]['date']}",
                ),
              ),
              DataCell(
                Text(
                  base["college"].toString().isEmpty
                      ? "-"
                      : "${base["college"]}",
                ),
              ),
            ],
          ),
        );
      }
    }
    return [playerNames, playerAttributes];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DataTable(
          columns: const [
            DataColumn(
              label: Text("Name"),
            ),
          ],
          rows: roster()[0],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Pos',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'No',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'H(m)',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'W(kg)',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'DOB',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'From',
                  ),
                ),
              ],
              rows: roster()[1],
            ),
          ),
        ),
      ],
    );
  }
}
