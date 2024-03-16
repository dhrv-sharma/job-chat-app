// need http package for the connection with api
import 'package:http/http.dart' as https;
import 'package:jobchat/models/auth/login_response.dart';
import 'package:jobchat/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authHelper {
  static var client = https.Client();

  static Future<bool> signUp(model) async {
    try {
      // step 1 headers required
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.signupUrl);

      var response =
          await client.post(url, headers: requestHeaders, body: model);

// creating status cdode
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> login(model) async {
    try {
      // step 1 headers required
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.loginUrl);

      var response =
          await client.post(url, headers: requestHeaders, body: model);

// creating status cdode
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var user = loginResponseModelFromJson(response.body);
        await prefs.setString('token', user.userToken);
        await prefs.setString('userId', user.id);
        await prefs.setString('profile', user.profile);
        await prefs.setString('username', user.username);
        await prefs.setBool('loggedIn', true);
        print("log in success");

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
