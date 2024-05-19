import 'package:flutter/material.dart';
import 'package:court_craze/constant.dart';
import 'package:court_craze/components/cacheimg.dart';
import 'package:court_craze/screens/views/teams_view/teaminfo.dart';
import 'package:provider/provider.dart';
import 'package:court_craze/json/jsons.dart';

// Generates list of teams in alphabetical order and displays as a card
List<Widget> teams(BuildContext context) {
  List<Widget> teamCard = [];
  Map allTeams = {}; // combine all teams into single map
  allTeams.addAll(eastID);
  allTeams.addAll(westID);
  for (String id in sortedIds) {
    teamCard.add(
      GestureDetector(
        onTap: () {
          dynamic teamsJson;
          if ((Provider.of<JsonFiles>(context, listen: false)
                      .getEastStandings() !=
                  null &&
              Provider.of<JsonFiles>(context, listen: false)
                      .getEastStandings() !=
                  null)) {
            if (allTeams[id][3] == "East") {
              int indexPos = Provider.of<JsonFiles>(context, listen: false)
                  .getEastIdIndex()[id];
              teamsJson = Provider.of<JsonFiles>(context, listen: false)
                  .getEastStandings()["response"][indexPos];
            } else if (allTeams[id][3] == "West") {
              int indexPos = Provider.of<JsonFiles>(context, listen: false)
                  .getWestIdIndex()[id];
              teamsJson = Provider.of<JsonFiles>(context, listen: false)
                  .getWestStandings()["response"][indexPos];
            }
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamDetails(
                teamurl: allTeams[id][2],
                json: teamsJson,
                name: allTeams[id][1],
              ),
            ),
          );
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: CachedLogo(
                      url: allTeams[id][2],
                      radius: 40,
                    ),
                  ),
                  Text(
                    allTeams[id][0].toString().toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  return teamCard;
}
