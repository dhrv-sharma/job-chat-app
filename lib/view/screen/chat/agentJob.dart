import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/agent_provider.dart';
import 'package:jobchat/models/agents.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/services/chat_service.dart';
import 'package:jobchat/view/common/NoSearchResult.dart';
import 'package:jobchat/view/screen/job/fullJobView.dart';
import 'package:provider/provider.dart';

class agentJob extends StatefulWidget {
  agentJob(
      {super.key,
      required this.uid,
      required this.myProfile,
      required this.agent});
  String uid;
  ProfileRes myProfile;
  Agents agent;

  @override
  State<agentJob> createState() => _agentJobState();
}

class _agentJobState extends State<agentJob> {
  @override
  Widget build(BuildContext context) {
    return Consumer<agentProvider>(builder: (context, agentNotify, child) {
      agentNotify.getAgentJobs(widget.uid);
      return FutureBuilder<List<Job>?>(
          future: agentNotify.agentJobs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Text("Error : ${snapshot.error.toString()}");
            } else {
              final job = snapshot.data!.reversed.toList();

              if (job.isEmpty) {
                return const Center(
                  child: NoSearchResults(message: "No Job posted by Agent"),
                );
              }
              return Container(
                margin: const EdgeInsets.only(top: 25),
                child: ListView.separated(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    itemCount: job.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (_, index) => const SizedBox(
                          height: 20,
                        ),
                    itemBuilder: (context, index) {
                      var mJob = job[index];
                      return GestureDetector(
                          onTap: () {
                            Get.to(fullJobView(
                              job: mJob,
                            ));
                          },
                          child: applyJobTile(
                            job: mJob,
                            showTime: true,
                            hiring: job[index].hiring,
                            agent: widget.agent,
                            myProfile: widget.myProfile,
                          ));
                    }),
              );
            }
          });
    });
  }
}

class applyJobTile extends StatefulWidget {
  const applyJobTile(
      {super.key,
      required this.job,
      required this.showTime,
      required this.hiring,
      required this.myProfile,
      required this.agent});
  final Job job;
  final ProfileRes myProfile;
  final Agents agent;

  final bool showTime;
  final bool hiring;

  @override
  State<applyJobTile> createState() => _applyJobTileState();
}

class _applyJobTileState extends State<applyJobTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(30),
          color: primaryColor.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.1)),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(widget.job.imageUrl),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.job.company!,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  chatServices srv = chatServices();

                  srv.getBubble(widget.myProfile);
                },
                child: Text(
                  widget.job.hiring ? "Hiring" : "Closed",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.job.hiring ? Colors.green : Colors.red),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.job.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.job.agentName,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.8)),
                  ),
                ],
              ),
              if (widget.showTime)
                iconText(widget.job.contract, Icons.access_time_outlined,
                    Colors.yellow)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(widget.job.location, Icons.location_on_outlined,
                  Colors.yellow),
              widget.job.hiring
                  ? SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () async {
                          chatServices srv = chatServices();
                          srv.applyJob(widget.myProfile, widget.agent);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text(
                          "Apply now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}

Widget iconText(String text, IconData icon, Color color) {
  return Row(
    children: [
      Icon(
        icon,
        color: color,
      ),
      const SizedBox(width: 10),
      Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.black),
      )
    ],
  );
}
