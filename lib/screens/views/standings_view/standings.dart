// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:court_craze/json/jsons.dart';
import 'package:court_craze/services/network.dart';
import 'package:court_craze/services/urls.dart';
import 'package:provider/provider.dart';
import 'package:court_craze/components/standings_widgets/tabbar.dart';
import 'package:court_craze/components/connection.dart';

class Standings extends StatefulWidget {
  const Standings({super.key});

  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  Future<bool> getFile() async {
    bool complete = false;
    try {
      var eastJson = await Network.getJson(
        Urls.eastStandingsUrl,
      );
      var westJson = await Network.getJson(
        Urls.westStandingsUrl,
      );
      Provider.of<JsonFiles>(context, listen: false).setEastStandings(eastJson);
      Provider.of<JsonFiles>(context, listen: false).setWestStandings(westJson);
      for (int idx = 0; idx < 15; idx++) {
        Provider.of<JsonFiles>(context, listen: false).setEastIdIndex(
            eastJson["response"][idx]["team"]['id'].toString(), idx);
        Provider.of<JsonFiles>(context, listen: false).setWestIdIndex(
            eastJson["response"][idx]["team"]['id'].toString(), idx);
      }
      if ((Provider.of<JsonFiles>(context, listen: false).getEastStandings() !=
              null) &&
          (Provider.of<JsonFiles>(context, listen: false).getWestStandings() !=
              null)) {
        complete = true; // data gotten
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return complete;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // hides back arrow button
          title: const TabBar(
            tabs: [
              Tab(
                text: "East",
              ),
              Tab(
                text: "West",
              )
            ],
          ),
        ),
        body: ((Provider.of<JsonFiles>(context, listen: false)
                        .getEastStandings()) ==
                    null &&
                (Provider.of<JsonFiles>(context, listen: false)
                        .getEastStandings() ==
                    null))
            ? FutureBuilder(
                future: getFile(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Widget table;
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == true) {
                      table = Bar(
                        eastTable:
                            Provider.of<JsonFiles>(context).getEastStandings(),
                        westTable:
                            Provider.of<JsonFiles>(context).getWestStandings(),
                      );
                    } else if (snapshot.data == false) {
                      table = const NoConnection();
                    }else {
                    table = const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  } else {
                    table = const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return table;
                },
              )
            : Bar(
                eastTable: Provider.of<JsonFiles>(context).getEastStandings(),
                westTable: Provider.of<JsonFiles>(context).getWestStandings(),
              ),
      ),
    );
  }
}
