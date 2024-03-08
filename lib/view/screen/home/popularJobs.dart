import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/jobs_provider.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/view/common/jobHorizontal.dart';
import 'package:jobchat/view/screen/job/jobview.dart';
import 'package:provider/provider.dart';

class popularJobs extends StatelessWidget {
  const popularJobs({super.key});

  @override
  Widget build(BuildContext context) {
    // future builder is wrapped inside the the consumer widget
    return Consumer<JobsNotifier>(builder: (context, JobsNotifier, child) {
      JobsNotifier.getAllJobs();
      return SizedBox(
        height: hieght * 0.28,
        // <We have to put that parameter on which my UI getting dependent here we are waiting for JobList  >

        child: FutureBuilder<List<Job>>(
            future: JobsNotifier.jobList,
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
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var mJob = job[index];
                      return jobHorizontalTile(
                        onTap: () {
                          Get.to(() => jobView(job: mJob));
                        },
                        job: mJob,
                      );
                    });
              }
            }),
      );
    });
  }
}
