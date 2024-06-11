import 'package:flutter/material.dart';

class skillsNotifier extends ChangeNotifier {
  bool _addSkills = false;

  bool get addSkills => _addSkills;

  set setSkills(bool newState) {
    _addSkills = newState;
    notifyListeners();
  }

  String _addSkillId = '';

  // return skill id

  String get addSkillsId => _addSkillId;

// set function no need to give argumnet as normal function metyhod just give through  =
  set setSkillsId(String newState) {
    _addSkillId = newState;
    notifyListeners();
  }
}
