import 'package:flutter/material.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/services/jobhelper.dart';

class searchNotifer extends ChangeNotifier {
  int selected = -1;

  int _selected() => selected;

  void change(int index) {
    selected = index;

    notifyListeners();
  }

  late Future<List<Job>> searchedJobs;
  Future<List<Job>> _searchedJobs() => searchedJobs;
  void search(String text) {
    searchedJobs = jobHelper.getSearchJob(text);
    notifyListeners();
  }
}
