import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/bookmark_provider.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/models/bookmark.dart/all_bookmarks.dart';
import 'package:jobchat/view/common/NoSearchResult.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/guest/non_user.dart';
import 'package:jobchat/view/screen/home/homepage.dart';
import 'package:jobchat/view/screen/job/fullJobView.dart';
import 'package:provider/provider.dart';

class bookaMark extends StatefulWidget {
  const bookaMark({super.key});

  @override
  State<bookaMark> createState() => _bookaMarkState();
}

class _bookaMarkState extends State<bookaMark> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: loginNotifier.loggedIn == false
          ? Color(kLight.value)
          : Color(kBlueColor.value),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppbar(
            color: loginNotifier.loggedIn == false
                ? Color(kLight.value)
                : Color(kBlueColor.value),
            textColor: loginNotifier.loggedIn == false
                ? Color(kDark.value)
                : Color(kLight.value),
            text: "Bookmarks",
            actions: const [],
            child: Padding(
                padding: EdgeInsets.all(12.0.h),
                child: DrawerWidget(
                  color: loginNotifier.loggedIn == false
                      ? Color(kDark.value)
                      : Color(kLight.value),
                )),
          )),
      body: loginNotifier.loggedIn == false
          ? const nonUser()
          : Consumer<BookMarkNotifier>(builder: (context, bookNotifier, child) {
              var bookMarks = bookNotifier.getBookMarks();

              return Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.w),
                              topLeft: Radius.circular(20.w),
                            ),
                            color: Color(kGreen.value),
                          ),
                          child: buildStyleContainer(
                            context,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: FutureBuilder<List<AllBookMarks>?>(
                                  future: bookMarks,
                                  builder: (context, snapShot) {
                                    if (snapShot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const PageLoader();
                                    } else if (snapShot.hasError) {
                                      return Text("Error ${snapShot.error}");
                                    } else {
                                      var bookList =
                                          snapShot.data!.reversed.toList();

                                      if (bookList.isEmpty) {
                                        return const NoSearchResults(
                                            message: "No Job is BookMarked");
                                      }
                                      return ListView.separated(
                                          separatorBuilder: (_, index) =>
                                              const SizedBox(
                                                height: 15,
                                              ),
                                          itemCount: bookList.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final book = bookList[index];

                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(() => fullJobView(
                                                      jobId: book.job.id,
                                                    ));
                                              },
                                              child: BookMarkTile(
                                                  imageUrl: book.job.imageUrl,
                                                  company: book.job.company,
                                                  contract: book.job.contract,
                                                  location: book.job.location,
                                                  title: book.job.title,
                                                  agentName: book.job.agentName,
                                                  hiring: book.job.hiring,
                                                  showTime: true),
                                            );
                                          });
                                    }
                                  }),
                            ),
                          )))
                ],
              );
            }),
    );
  }
}
