import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/zoom_provider.dart';
import 'package:jobchat/models/agents.dart';
import 'package:jobchat/models/getAgent.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/services/agentHelper.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';

import 'package:provider/provider.dart';

class agentProvider extends ChangeNotifier {
  bool applying = false;

  bool get _applying => applying;
  void updates(bool update) {
    applying = update;
    notifyListeners();
  }

// to apply for agent
  void applyAgent(String model, BuildContext context) async {
    updates(true);
    agentHelper.becomeAgent(model).then((response) async {
      if (response == true) {
        Get.snackbar(
            "Profile Updated", "Now People can see your updated Profile",
            colorText: Color(kLight.value),
            backgroundColor: Colors.green,
            icon: const Icon(
              Icons.add_alert,
              color: Colors.white,
            ),
            borderRadius: 5);

        var zoomNotifier = Provider.of<ZoomNotifier>(context, listen: false);

        zoomNotifier.currentIndex = 4;

        Get.offAll(const mainScreen());

        updates(false);
      } else {
        Get.snackbar("Something went Wrong", "Please try again",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(
              Icons.add_alert,
              color: Colors.white,
            ),
            borderRadius: 5);

        updates(false);
      }
    });
  }

  // importing agents from the server
  late List<Agents> allAgents;

  Future<List<Agents>?> getAllAgent() async {
    var agents = agentHelper.getAgents();

    return agents;
  }

  Agents? agent;

  Future<GetAgent?> getAgentinfo(String uid) async {
    var agentInfo = agentHelper.getSingleAgent(uid);

    return agentInfo;
  }

  late Future<List<Job>?> agentJobs;

  Future<List<Job>?> getAgentJobs(String uid) {
    agentJobs = agentHelper.getAgentJobs(uid);
    return agentJobs;
  }
}
