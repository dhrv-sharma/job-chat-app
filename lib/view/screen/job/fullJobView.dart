import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/bookmark_provider.dart';
import 'package:jobchat/controllers/jobs_provider.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/controllers/zoom_provider.dart';
import 'package:jobchat/models/bookmark.dart/book_res.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/view/common/NoSearchResult.dart';

import 'package:jobchat/view/common/pageloader.dart';

import 'package:jobchat/view/common/widthspacer.dart';
import 'package:jobchat/view/screen/home/homepage.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';
import 'package:jobchat/view/screen/profile/profile.dart';
import 'package:provider/provider.dart';

class fullJobView extends StatefulWidget {
  const fullJobView({super.key, this.job, this.jobId});

  final Job? job;
  final String? jobId;

  @override
  State<fullJobView> createState() => _fullJobViewState();
}

class _fullJobViewState extends State<fullJobView> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      body: Consumer<JobsNotifier>(
        builder: (context, jobsNotifier, child) {
          String id;
          if (widget.job == null) {
            id = widget.jobId!;
          } else {
            id = widget.job!.id;
          }
          jobsNotifier.getJob(id);
          return FutureBuilder<Job>(
              future: jobsNotifier.job,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // runs when the future builder loading data
                  return const Center(
                    child: PageLoader(),
                  );
                } else if (snapshot.hasError) {
                  // when there is some error
                  return Text("Error: +${snapshot.error}");
                } else if (snapshot.data == Null) {
                  // not able to find
                  return const NoSearchResults(message: "Not able to Load");
                } else {
                  // job found
                  final job = snapshot.data;
                  return Container(
                    padding: const EdgeInsets.all(25),
                    width: width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_outlined,
                                      size: 30,
                                    )),
                                const widthSpacer(size: 10),
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(0.1)),
                                  child: circularAvtr(
                                      image: job!.imageUrl,
                                      width: 40,
                                      height: 40),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  job.company.toString(),
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                loginNotifier.loggedIn == false
                                    ? const SizedBox.shrink()
                                    : Consumer<BookMarkNotifier>(builder:
                                        (context, bookNotifier, child) {
                                        bookNotifier.getBookMark(id);

                                        return GestureDetector(
                                          onTap: () {
                                            if (bookNotifier.bookmarkget ==
                                                true) {
                                              bookNotifier.deleteBookMark(
                                                  bookNotifier.bookmarkIdGet);
                                            } else {
                                              BookMarkReqRes model =
                                                  BookMarkReqRes(job: id);
                                              var encModel =
                                                  bookMarkReqResToJson(model);
                                              bookNotifier
                                                  .addBookMark(encModel);
                                            }
                                          },
                                          child: Icon(
                                              bookNotifier.bookmarkget
                                                  ? Icons.bookmark
                                                  : Icons
                                                      .bookmark_outline_outlined,
                                              color: bookNotifier.bookmarkget
                                                  ? primaryColor
                                                  : Colors.black),
                                        );
                                      }),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          job.title.toString(),
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            iconText(job.location, Icons.location_on_outlined,
                                Colors.yellow),
                            const SizedBox(
                              width: 15,
                            ),
                            iconText(job.contract, Icons.access_time_outlined,
                                Colors.yellow)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            iconText(job.salary, Icons.payment_outlined,
                                Colors.green),
                            const SizedBox(
                              width: 2,
                            ),
                            Text("/${job.period}")
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Posted By : ${job.agentName}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              job.hiring ? "Hiring" : "Closed",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      job.hiring ? Colors.green : Colors.red),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Description : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          job.description,
                          style: const TextStyle(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Requirement : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...job.requirements
                            .map((req) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        height: 5,
                                        width: 5,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxWidth: 300),
                                          child: Text(
                                            req,
                                            style: const TextStyle(
                                                wordSpacing: 2.5, height: 1.5),
                                          ))
                                    ],
                                  ),
                                ))
                            .toList(),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 25),
                          height: 45,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () {
                              if (loginNotifier.loggedIn) {
                              } else {
                                var zoomNotifier = Provider.of<ZoomNotifier>(
                                    context,
                                    listen: false);

                                zoomNotifier.currentIndex = 4;

                                Get.offAll(const mainScreen());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Text(
                              loginNotifier.loggedIn == false
                                  ? "Please Login"
                                  : "Apply now",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )),
                  );
                }
              });
        },
      ),
    );
  }
}
