import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/exports.dart';
import 'package:jobchat/controllers/login_provider.dart';

// directory add in this way
import 'package:jobchat/view/screen/boarding/boardingscreen.dart';
import 'package:provider/provider.dart';

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

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => SignUpNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
            // setting the color of the common parramters
            theme: ThemeData(
              scaffoldBackgroundColor: Color(kLight.value),
              iconTheme: IconThemeData(color: Color(kDark.value)),
              primarySwatch: Colors.grey,
            ),
            home: const OnBoardingScreen(),
          );
        });
  }
}
