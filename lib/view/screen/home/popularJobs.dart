import 'package:flutter/material.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/jobs_provider.dart';
import 'package:jobchat/models/job.dart';

import 'package:jobchat/view/common/jobHorizontal.dart';

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
                        onTap: () {},
                        company: mJob.company!,
                        description: mJob.title,
                        location: mJob.location,
                        salary: mJob.salary,
                        period: mJob.period,
                        imageUrl: mJob.imageUrl,
                      );
                    });
              }
            }),
      );
    });
  }
}
