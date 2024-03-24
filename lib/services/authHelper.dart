// need http package for the connection with api
import 'package:http/http.dart' as https;
import 'package:jobchat/models/auth/login_response.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authHelper {
  static var client = https.Client();

  static Future<bool> signUp(String model) async {
    try {
      // step 1 headers required
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.signupUrl);

      var response =
          await client.post(url, headers: requestHeaders, body: model);

      // checking status cdode
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login(String model) async {
    // step 1 headers required
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.loginUrl);

    var response = await client.post(url, headers: requestHeaders, body: model);

    // checking status cdode
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = loginResponseModelFromJson(response.body);
      await prefs.setString('token', user.userToken);
      await prefs.setString('userId', user.id);
      await prefs.setString('profile', user.profile);
      await prefs.setString('username', user.username);
      await prefs.setBool('loggedIn', true);

      return true;
    } else {
      return false;
    }
  }

// get profile user function
  static Future<ProfileRes?> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No authentication token provided");
    }

    // step 1 headers required here we doing our authorization
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    // /api/user/
    var url = Uri.https(Config.apiUrl, Config.profileUrl);

    // get
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    // checking status cdode
    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      return profile;
    } else {
      throw Exception('Failed To Load Profile');
    }
  }
}
