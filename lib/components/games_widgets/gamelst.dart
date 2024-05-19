import 'package:flutter/material.dart';
import 'package:court_craze/components/games_widgets/game_card.dart';
// import 'package:court_craze/components/games_widgets/time.dart';
import 'package:court_craze/model/game_details.dart';

class SeasonGames extends StatelessWidget {
  final dynamic jsonFile;
  const SeasonGames({super.key, this.jsonFile,});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: jsonFile["response"].length,
        itemBuilder: (context, index) {
          Widget card;
          {
            dynamic json = jsonFile["response"][index];

            card = Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GameCard(
                details: GameDetails(
                    homeTeamLogo: json["teams"]["home"]['logo'],
                    homeTeamPoints: json["scores"]["home"]["points"] ?? 0,
                    awayTeamLogo: json["teams"]["visitors"]['logo'],
                    awayTeamPoints: json["scores"]["visitors"]["points"] ?? 0,
                    gameTime: json["date"]['start']),
              ),
            );
          }
          return card;
        },
      ),
    );
  }
}
