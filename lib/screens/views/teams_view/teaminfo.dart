import 'package:court_craze/components/cacheimg.dart';
import 'package:court_craze/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:court_craze/components/teams_widgets/statcard.dart';
import 'package:court_craze/components/teams_widgets/playerlst.dart';
import 'package:court_craze/services/network.dart';
import 'package:court_craze/services/urls.dart';
import 'package:court_craze/components/connection.dart';

class TeamDetails extends StatefulWidget {
  final dynamic json;
  final String teamurl;
  final String name;
  const TeamDetails(
      {super.key,
      required this.json,
      required this.teamurl,
      required this.name});

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  Widget build(BuildContext context) {
    // Future<void> _launched;
    Future<void> launched = Future<void>.value(null); // Initialize with null
    final String streak = widget.json != null
        ? widget.json["winStreak"]
            ? "W"
            : "L"
        : ""; // has the team been on a winning or losing streak
    return Scaffold(
      appBar: customAppBar(automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.json == null
            ? const NoConnection()
            : ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CachedLogo(
                                url: widget.teamurl,
                                radius: 45,
                              ),
                              GestureDetector(
                                onTap: () {
                                  String name = widget.name == "76ers"
                                      ? "sixers"
                                      : widget.name.toLowerCase();
                                  setState(
                                    () {
                                      launched = Network.launchSite(
                                        Urls.link(
                                          name,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      widget.name,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.link,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  StatCard(
                                    item1:
                                        "Home: ${widget.json["win"]["home"]} - ${widget.json["loss"]["home"]}",
                                    item2:
                                        "Road: ${widget.json["win"]["away"]} - ${widget.json["loss"]["away"]}",
                                    item3:
                                        "Last 10: ${widget.json['win']["lastTen"]} - ${widget.json['loss']["lastTen"]}",
                                    item4:
                                        "Streak: $streak ${widget.json["streak"]}",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  StatCard(
                                    item1:
                                        "Win: ${widget.json["win"]['total']}",
                                    item2:
                                        "Loss: ${widget.json["loss"]['total']}",
                                    item3:
                                        "Pct: ${double.parse(widget.json['win']["percentage"]) * 100}%",
                                    item4: "GB: ${widget.json["gamesBehind"]}",
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  StatCard(
                                    item1: "Division",
                                    item2: widget.json["division"]["name"]
                                        .toString()
                                        .toUpperCase(),
                                    item3:
                                        "${widget.json["division"]["win"]} - ${widget.json["division"]["loss"]}",
                                    item4:
                                        "Rank: ${widget.json["division"]["rank"]}",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  StatCard(
                                    item1: "Conference",
                                    item2: widget.json["conference"]["name"]
                                        .toString()
                                        .toUpperCase(),
                                    item3:
                                        "${widget.json["conference"]["win"]} - ${widget.json["conference"]["loss"]}",
                                    item4:
                                        "Rank: ${widget.json["conference"]["rank"]}",
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Roster",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //Roster()
                  PlayerList(
                    teamId: widget.json["team"]['id'].toString(),
                  ),

                  FutureBuilder<void>(
                    // launch the teams official website
                    future: launched,
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('');
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
