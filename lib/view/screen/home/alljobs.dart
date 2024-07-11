import 'package:flutter/material.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/jobs_provider.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/view/screen/home/homepage.dart';
import 'package:jobchat/view/screen/job/jobview.dart';
import 'package:provider/provider.dart';

class allJobWidget extends StatelessWidget {
  const allJobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // future builder is wrapped inside the the consumer widget
    return Consumer<JobsNotifier>(builder: (context, JobsNotifier, child) {
      JobsNotifier.getAllJobs();
      return SizedBox(
        height: hieght * 0.28,
        // <We have to put that parameter on which my UI getting dependent here we are waiting for JobList  >

        child: FutureBuilder<List<Job>>(
            future: JobsNotifier.getAllJobs(),
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
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  height: 160,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      jobView(job: job[index]));
                            },
                            child: jobTile(
                              job: job[index],
                              showTime: true,
                              hiring: job[index].hiring,
                            ),
                          );
                        });
                      },
                      separatorBuilder: (_, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount: job!.length),
                );
              }
            }),
      );
    });
  }
}
