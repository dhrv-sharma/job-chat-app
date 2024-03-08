import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobchat/controllers/jobs_provider.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/view/common/jobsVerticaltTiles.dart';
import 'package:jobchat/view/screen/job/jobview.dart';
import 'package:provider/provider.dart';

class recentList extends StatefulWidget {
  const recentList({super.key});

  @override
  State<recentList> createState() => _recentListState();
}

// horizontal scroll view need height fixed but not for Vertical Scroll
class _recentListState extends State<recentList> {
  @override
  Widget build(BuildContext context) {
    // future builder is wrapped inside the the consumer widget
    return Consumer<JobsNotifier>(builder: (context, JobsNotifier, child) {
      JobsNotifier.getRecentJobs();
      return SizedBox(
        // <We have to put that parameter on which my UI getting dependent here we are waiting for JobList  >

        child: FutureBuilder<List<Job>>(
            future: JobsNotifier.jobRecent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: +${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return const Text("No jobs Found");
              } else {
                final job = snapshot.data;
                return ListView.builder(
                    itemCount: job!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: JobsVerticalTile(
                              onTap: () {
                                Get.to(() => jobView(job: job[index]));
                              },
                              job: job[index]));
                    });
              }
            }),
      );
    });
  }
}
