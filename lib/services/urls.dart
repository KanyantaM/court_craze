class Urls {
  static const String _apiBaseUrl = "https://api-nba-v1.p.rapidapi.com";
  static const String _teamBaseUrl = "https://www.nba.com/";
  static String eastStandingsUrl =
      "$_apiBaseUrl/standings?league=standard&season=2023&conference=east";
  static String westStandingsUrl =
      "$_apiBaseUrl/standings?league=standard&season=2023&conference=west";
  static String eastTeamsUrl = "$_apiBaseUrl/teams?conference=East";
  static String westTeamsUrl = "$_apiBaseUrl/teams?conference=West";

  static String seasonGames(DateTime? date) {
    if (date == null) {
      DateTime.now();
    }
    return "$_apiBaseUrl/games?date=${date!.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static String teamPlayersUrl(String id) =>
      "$_apiBaseUrl/players?team=$id&season=${DateTime.now().year - 1}";
  static String link(String team) => "$_teamBaseUrl$team/";
}
