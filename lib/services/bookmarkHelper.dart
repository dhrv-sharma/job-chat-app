import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobchat/models/bookmark.dart/all_bookmarks.dart';
import 'package:jobchat/models/bookmark.dart/bookmark.dart';
import 'package:jobchat/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bookMarkHelper {
  static var client = https.Client();

// give json data into the string
// create bookMark

// api/bookmark/create
  static Future<BookMark?> addBookMark(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // step 1 headers required here we doing our authorization
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    if (token == null) {
      return null;
    }

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrlCreate);

    var response = await client.post(url, headers: requestHeaders, body: model);

    // checking status cdode
    if (response.statusCode == 200) {
      var bookmark = bookMarkFromJson(response.body);
      return bookmark;
    } else {
      throw Exception('Failed To book mark');
    }
  }

// /api/bookmark/
  static Future<List<AllBookMarks>?> getAllBookMarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // step 1 headers required here we doing our authorization
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

    if (token == null) {
      return null;
    }

// /api/bookmark/
    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    // checking status cdode
    if (response.statusCode == 200) {
      List<AllBookMarks> marks = [];

      List bookmark = jsonDecode(response.body);
      bookmark.forEach((element) {
        marks.add(AllBookMarks.fromJson(element));
      });
      return marks;
    } else {
      throw Exception('Failed To Load Your Book Mark');
    }
  }

// get single bookmark
// api/bookmark/single/:id
  static Future<BookMark?> getSingleBookMark(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return null;
    }

    // step 1 headers required here we doing our authorization

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

//  get single bookmark
// /api/bookmark/single/:id
    var url = Uri.https(Config.apiUrl, "${Config.singleBookmarkUrl}${jobId}");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    // checking status cdode
    if (response.statusCode == 200) {
      var bookmark = bookMarkFromJson(response.body);
      return bookmark;
    } else {
      throw Exception('Failed To Load Your Book Mark');
    }
  }

  // delete bookmark
  // /api/bookmark/:id
  static Future<bool?> deleteBookMark(String bookMarkId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return null;
    }

    // step 1 headers required here we doing our authorization
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    };

// /api/bookmark/
    var url = Uri.https(Config.apiUrl, "${Config.bookmarkUrl}${bookMarkId}");

// delete function
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    // checking status cdode
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed To Load Your Book Mark');
    }
  }
}
