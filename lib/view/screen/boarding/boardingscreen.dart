import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/exports.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';

import 'package:jobchat/view/screen/boarding/pageOne.dart';
import 'package:jobchat/view/screen/boarding/pageThree.dart';
import 'package:jobchat/view/screen/boarding/pageTwo.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    // for disposing controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // means this part of the widget depends upon the boardNotifier
    return Consumer<OnBoardNotifier>(
        builder: (context, onBoardNotifier, child) {
      return Scaffold(
          body: Stack(
        children: [
          // page view is an inbuilt widget for the boarding screen pages
          //  after reaching the last page we cant reach at the first page that we need state mangement Provider
          PageView(
            // these are the boarding pages
            physics: onBoardNotifier.isLastPage
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            controller: pageController,
            children: const [pageOne(), pageTwo(), pageThree()],
            onPageChanged: (pageIndex) {
              // fucntion when page get changed
              // onBoardNotifier.isLastPage =  pageIndex==2;
              if (pageIndex == 2) {
                onBoardNotifier.isLastPage = true;
              }
            },
          ),

          // page level indicator
          Positioned(
              left: 0,
              right: 0,
              bottom: hieght * 0.09,
              child: Center(
                child: onBoardNotifier.isLastPage
                    ? const SizedBox.shrink()
                    : SmoothPageIndicator(
                        // packaage import from dev
                        controller: pageController, // page controller
                        count: 3, // number of pages
                        effect: WormEffect(
                            // type of indicator
                            dotHeight: 12, //height of the dot
                            dotWidth: 12, // width of dot
                            spacing: 10,
                            dotColor: Color(kDarkGrey.value)
                                .withOpacity(0.5), // default color of dot
                            activeDotColor: Color(
                                kLight.value))), // selected color of the dot
              )),
          //   skip adn next  button
          Positioned(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: onBoardNotifier.isLastPage
                ? const SizedBox.shrink() // a sized box with zero dimensions
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(2);
                          },
                          child: reusableText(
                              text: "Skip",
                              style: appStyle(
                                  16, Color(kLight.value), FontWeight.w500)),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          child: reusableText(
                              text: "Next",
                              style: appStyle(
                                  16, Color(kLight.value), FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
          )),
        ],
      ));
    });
  }
}
