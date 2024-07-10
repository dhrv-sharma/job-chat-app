import 'dart:convert';

import 'package:jobchat/models/getAgent.dart';
import 'package:jobchat/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;

class agentHelper {
  static var client = https.Client();

  static Future<bool> becomeAgent(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // step 1 headers required here we doing our authorization
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    if (token == null) {
      return false;
    }

    // /api/job/
    var url = Uri.https(Config.apiUrl, Config.becomeAgent);

    var response = await client.post(url, headers: requestHeaders, body: model);

    // checking status cdode
    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<List<GetAgent>?> getAgents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // step 1 headers required here we doing our authorization
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    if (token == null) {
      List<GetAgent> agent = [];

      return agent;
    }

// /api/bookmark/
    var url = Uri.https(Config.apiUrl, Config.getAgents);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    // checking status cdode
    if (response.statusCode == 200) {
      List<GetAgent> agent = [];

      List resAgent = jsonDecode(response.body);
      resAgent.forEach((element) {
        agent.add(GetAgent.fromJson(element));
      });

      return agent;
    } else {
      throw Exception('Failed To Load Agents');
    }
  }
}
