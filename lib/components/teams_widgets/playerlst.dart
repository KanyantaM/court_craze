import 'package:flutter/material.dart';
import 'package:court_craze/json/jsons.dart';
import 'package:court_craze/components/teams_widgets/roster.dart';
import 'package:court_craze/services/network.dart';
import 'package:court_craze/services/urls.dart';
import 'package:provider/provider.dart';

class PlayerList extends StatelessWidget {
  final String teamId;
  const PlayerList({super.key, required this.teamId});
  @override
  Widget build(BuildContext context) {
    return Provider.of<JsonFiles>(context, listen: false)
                .getTeamRoster(teamId) ==
            null
        ? FutureBuilder<dynamic>(
            future: Network.getJson(Urls.teamPlayersUrl(teamId)),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget playerList;
              if (snapshot.hasData) {
                Provider.of<JsonFiles>(context, listen: false).addTeamPlayers(
                    teamId, snapshot.data); // add teamRoster json to Provider
                playerList = Roster(
                  json: snapshot.data,
                );
              } else if (snapshot.hasError) {
                playerList = const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 50,
                    ),
                    Text("Something went wrong!"),
                  ],
                );
              } else {
                playerList = const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return playerList;
            },
          )
        : Roster(
            json: Provider.of<JsonFiles>(context, listen: false)
                .getTeamRoster(teamId),
          );
  }
}
