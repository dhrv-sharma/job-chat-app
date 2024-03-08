import 'package:flutter/foundation.dart';


import 'package:jobchat/models/job.dart';


import 'package:jobchat/services/jobhelper.dart';


class JobsNotifier extends ChangeNotifier {

  // in the services we are rturning Future list


  late Future<List<Job>> jobList;

  late Future<List<Job>> jobRecent;


  late Future<Job> job;


  // calling our restful api from here


  Future<List<Job>> getAllJobs() {

    jobList = jobHelper.getJobs();


    return jobList;

  }


  // calling our restful api from job


  Future<Job> getJob(String jobId) {

    job = jobHelper.getSingleJob(jobId);


    return job;

  }

  Future<List<Job>> getRecentJobs() {

    jobRecent = jobHelper.getRecentJobs();


    return jobRecent;

  }

}

