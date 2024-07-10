import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/zoom_provider.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/services/agentHelper.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';
import 'package:jobchat/services/authHelper.dart';

import 'package:provider/provider.dart';

class agentProvider extends ChangeNotifier {
  bool applying = false;

  bool get _applying => applying;
  void updates(bool update) {
    applying = update;
    notifyListeners();
  }

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
}
