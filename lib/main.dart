import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/bookmark_provider.dart';
import 'package:jobchat/controllers/exports.dart';
import 'package:jobchat/controllers/jobs_provider.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/controllers/profile_provider.dart';

// directory add in this way
import 'package:jobchat/view/screen/boarding/boardingscreen.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// imports
//  screenutil , google fonts , provider, smooth page indicator for onboard screen indicators

// entry point of the program
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // multiproviders
  // runApp(MultiProvider(providers: const [
  //   // ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
  //   // ChangeNotifierProvider(create: (context) => LoginNotifier()),
  //   // ChangeNotifierProvider(create: (context) => ZoomNotifier()),
  //   // ChangeNotifierProvider(create: (context) => SignUpNotifier()),
  //   // ChangeNotifierProvider(create: (context) => JobsNotifier()),
  //   // ChangeNotifierProvider(create: (context) => BookMarkNotifier()),
  //   // ChangeNotifierProvider(create: (context) => ImageUpoader()),
  //   // ChangeNotifierProvider(create: (context) => ProfileNotifier()),
  // ], child: const MyApp()));

  bool check = false;

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool("entrypoint") == true) {
    check = true;
  } else {
    check = false;
  }

  var username = prefs.getString('username') ?? '';

  var userId = prefs.getString('userId') ?? '';

  var profile = prefs.getString('profile') ??
      'https://res.cloudinary.com/dap69mong/image/upload/v1710654983/fbdrtr3b8spuotwu3r28.jpg';

  var loggedIn = prefs.getBool('loggedIn') ?? false;

  userNameConst = username;

  userIdConst = userId;

  profileConst = profile;
  print(profileConst);

  loggedInconst = loggedIn;

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
        ChangeNotifierProvider(create: (context) => LoginNotifier()),
        ChangeNotifierProvider(create: (context) => SignUpNotifier()),
        ChangeNotifierProvider(create: (context) => ZoomNotifier()),
        ChangeNotifierProvider(create: (context) => JobsNotifier()),
        ChangeNotifierProvider(create: (context) => ProfileNotifier()),
        ChangeNotifierProvider(create: (context) => BookMarkNotifier())
      ],
      child: MyApp(
        check: check,
      )));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.check});

  bool check;

  @override
  Widget build(BuildContext context) {
    //  screen util is used for adaptive size and remove resoultion problem

    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'JobHub',
            // setting the color of the common paramters
            theme: ThemeData(
              scaffoldBackgroundColor: Color(kLight.value),
              iconTheme: IconThemeData(color: Color(kDark.value)),
              primarySwatch: Colors.grey,
            ),
            home: check ? const mainScreen() : const OnBoardingScreen(),
          );
        });
  }
}
