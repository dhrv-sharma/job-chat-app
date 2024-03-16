import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobchat/models/job.dart';
import 'package:jobchat/services/config.dart';

// contains the services
class jobHelper {
  static var client = https.Client();

  // get all the jobs function
  // Job is model
  // /api/job/
  static Future<List<Job>> getJobs() async {
    // used for the communication
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // our url
    var url = Uri.https(Config.apiUrl, Config.job);
    // return list
    List<Job> jobList = [];
    // get the data from the backend
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // decoded in to the list containing map items
      List res = jsonDecode(response.body);
      res.forEach((element) {
        // map items to job object
        jobList.add(Job.fromJson(element));
      });
      return jobList;
    } else {
      throw Exception('Faliled To Load Jobs ');
    }
  }

  // get single job function
  // /api/job/:id
  static Future<Job> getSingleJob(String jobId) async {
    // used for the communication
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // our url
    var url = Uri.https(Config.apiUrl, "${Config.job}/${jobId}");
    // return list
    Job job;
    // get the data from the backend
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // decoded in to the list containing map items
      var res = jsonDecode(response.body);
      job = Job.fromJson(res);

      return job;
    } else {
      throw Exception('Faliled To Load Job ');
    }
  }

  // get recent job from the server
  static Future<List<Job>> getRecentJobs() async {
    // used for the communication
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // url which you get through the new=true
    // here the new is a query parameter new
    var url = Uri.https(Config.apiUrl, Config.job, {"new": "true"});
    // return list
    List<Job> jobList = [];
    // get the data from the backend
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // decoded in to the list containing map items
      List res = jsonDecode(response.body);
      res.forEach((element) {
        // map items to job object
        jobList.add(Job.fromJson(element));
      });
      return jobList;
    } else {
      throw Exception('Faliled To Load Jobs ');
    }
  }

  static Future<List<Job>> getSearchJob(String search) async {
    // used for the communication
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // url which you get through the new=true
    var url = Uri.https(Config.apiUrl, "${Config.search}/$search");
    print(url);
    // return list
    List<Job> jobList = [];
    // get the data from the backend
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // decoded in to the list containing map items
      List res = jsonDecode(response.body);
      res.forEach((element) {
        // map items to job object
        jobList.add(Job.fromJson(element));
      });
      return jobList;
    } else {
      throw Exception('Faliled To Load Jobs ');
    }
  }
}
