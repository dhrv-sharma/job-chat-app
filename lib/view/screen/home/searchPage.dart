import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:jobchat/constants/app_constants.dart';

import 'package:jobchat/models/job.dart';
import 'package:jobchat/services/jobhelper.dart';
import 'package:jobchat/view/common/NoSearchResult.dart';
import 'package:jobchat/view/common/customefield.dart';
import 'package:jobchat/view/common/jobsVerticaltTiles.dart';
import 'package:jobchat/view/common/pageloader.dart';

import 'package:jobchat/view/screen/job/jobview.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kLight.value).withOpacity(0.4),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
          child: CustomField(
            controller: controller,
            onTap: () {
              setState(() {});
            },
          ),
        ),
      ),
      body: controller.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: SizedBox(
                // <We have to put that parameter on which my UI getting dependent here we are waiting for JobList  >
                child: FutureBuilder<List<Job>>(
                    future: jobHelper.getSearchJob(controller.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: PageLoader());
                      } else if (snapshot.hasError) {
                        return Text("Error: +${snapshot.error}");
                      } else if (snapshot.data!.isEmpty) {
                        return const NoSearchResults(message: "No Jobs Found");
                      } else {
                        final job = snapshot.data!.reversed.toList();
                        return ListView.builder(
                            itemCount: job.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var mJob = job[index];
                              return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0.w),
                                  child: JobsVerticalTile(
                                      job: mJob,
                                      onTap: () {
                                        Get.to(() => jobView(job: mJob));
                                      }));
                            });
                      }
                    }),
              ))
          : const NoSearchResults(message: "Start Searching....."),
    );
  }
}
