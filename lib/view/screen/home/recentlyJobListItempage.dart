import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobchat/controllers/jobs_provider.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/common/uploadedTile.dart';
import 'package:jobchat/view/screen/job/jobview.dart';
import 'package:provider/provider.dart';

class recentlyJobListItem extends StatelessWidget {
  const recentlyJobListItem({super.key});

  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobNotifer, chi) {
      // getting all the jobs
      //  uploaded tile is the single element
      jobNotifer.getRecentJobs();
      return SizedBox(
        // <We have to put that parameter on which my UI getting dependent here we are waiting for JobList  >
        child: FutureBuilder<List<Job>>(
            future: jobNotifer.jobRecent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: PageLoader());
              } else if (snapshot.hasError) {
                return Text("Error: +${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return const Text("No jobs Found");
              } else {
                final job = snapshot.data!.reversed.toList();
                return ListView.builder(
                    itemCount: job.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var mJob = job[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                        child: uploadedTile(
                            job: mJob,
                            text: "popular",
                            onTap: () {
                              Get.to(() => jobView(job: mJob));
                            }),
                      );
                    });
              }
            }),
      );
    });
  }
}
