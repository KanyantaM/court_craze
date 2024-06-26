import 'dart:convert' as convert;
import 'package:court_craze/services/api_ey/key.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Network {
  /*
   * Class is responsible for sending our get request to the NBA-API
   * each method of the class sends a get request for a particular data-endpoint for properties of the app
   * 1. get latest standings for bothe Eastern and Western Conference
   * 2. get scores of NBA games played
   * 3. get player statics such as ppg, apg, rpg, FG%, 
   */

  // make request to get Json file
  static Future<dynamic> getJson(
    String url,
  ) async {
    // make request to get Json file
    try {
      var response = await http.get(Uri.parse(url), headers: NbaApi.headers);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var json = convert.jsonDecode(response.body);
          return json;
        }
      }
    } catch (e) {
      Exception(e);
    }
  }

  static Future<void> launchSite(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
