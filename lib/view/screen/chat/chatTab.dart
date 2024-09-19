import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/agent_provider.dart';
import 'package:jobchat/models/agents.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/models/chatttedPeople.dart';
import 'package:jobchat/models/message.dart';
import 'package:jobchat/services/chat_service.dart';
import 'package:jobchat/view/common/NoSearchResult.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';
import 'package:jobchat/view/screen/chat/agentDetails.dart';
import 'package:jobchat/view/screen/profile/profile.dart';
import 'package:provider/provider.dart';

class chatTab extends StatefulWidget {
  chatTab({super.key, required this.myProfile});

  ProfileRes myProfile;

  @override
  State<chatTab> createState() => _chatTabState();
}

class _chatTabState extends State<chatTab> {
  chatServices chatDetails = chatServices();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 20,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 0.w),
              height: 220.h,
              decoration: BoxDecoration(
                  color: Color(kBlueColor.value),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableText(
                          text: "Agent and Companies",
                          style: appStyle(
                              12, Color(kLight.value), FontWeight.normal)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            AntDesign.ellipsis1,
                            color: Color(kLight.value),
                          ))
                    ],
                  ),
                  Consumer<agentProvider>(
                      builder: (context, agentNotifier, child) {
                    var agents = agentNotifier.getAllAgent();
                    return FutureBuilder<List<Agents>?>(
                        future: agents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              height: 90.h,
                              child: Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Color(kLight.value),
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error : ${snapshot.error}");
                          } else {
                            return SizedBox(
                              height: 90.h,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var agent = snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () {
                                        // function

                                        agentNotifier.agent =
                                            snapshot.data![index];
                                        Get.to(() => agentDetailPage(
                                              myProfile: widget.myProfile,
                                            ));
                                      },
                                      child: widget.myProfile.uid != agent.uid
                                          ? buildAgentAvatar(
                                              agent.username, agent.profile)
                                          : const SizedBox.shrink(),
                                    );
                                  }),
                            );
                          }
                        });
                  })
                ],
              ),
            )),
        Positioned(
            top: 165.h,
            right: 0,
            left: 0,
            child: Container(
              width: width,
              height: hieght,
              decoration: BoxDecoration(
                  color: Color(kLight.value),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 8, top: 9, bottom: 0),
                child: FutureBuilder<chatPeople?>(
                    future: chatDetails.getBubble(widget.myProfile),
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: width,
                          child: const Center(
                              child: CircularProgressIndicator.adaptive()),
                        );
                      } else if (snapShot.hasError) {
                        return Text("Error ${snapShot.error}");
                      } else {
                        var chatRow = snapShot.data!;

                        if (chatRow.uniqueID.isEmpty) {
                          return const NoSearchResults(
                              message: "Not Applied For Any Job");
                        }
                        return ListView.separated(
                            separatorBuilder: (_, index) => const SizedBox(
                                  height: 9,
                                ),
                            itemCount: chatRow.uniqueID.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final msg = chatRow.messages[index];

                              return GestureDetector(
                                  onTap: () {},
                                  child:
                                      buildChatRow(msg, widget.myProfile.uid));
                            });
                      }
                    }),
              ),
            ))
      ],
    );
  }
}

// conversation row
Column buildChatRow(message msg, String myId) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          circularAvtr(
              image: myId == msg.senderId
                  ? msg.recieverProfile
                  : msg.senderProfile,
              width: 50,
              height: 50),
          const widthSpacer(size: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const heightSpacer(size: 5),
              reusableText(
                  text: myId == msg.senderId
                      ? msg.recieverUsername
                      : msg.senderUsername,
                  style:
                      appStyle(12, Color(primaryColor.value), FontWeight.w600)),
              SizedBox(
                  width: width * 0.7,
                  child: reusableText(
                      text: msg.msg,
                      style: appStyle(
                          12, Colors.black.withOpacity(0.8), FontWeight.w500)))
            ],
          )
        ],
      ),
      const heightSpacer(size: 8),
      Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
        width: width,
        height: 1,
      )
    ],
  );
}

// agent avatar circular image
Padding buildAgentAvatar(String name, String profileImage) {
  return Padding(
    padding: EdgeInsets.only(right: 15.w),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(99.w)),
              border: Border.all(
                width: 1,
                color: Color(kLight.value),
              )),
          // circular avatar picked from the profile page
          child: circularAvtr(
            image: profileImage,
            width: 50,
            height: 50,
          ),
        ),
        const heightSpacer(size: 5),
        reusableText(
            text: name,
            style: appStyle(11, Color(kLight.value), FontWeight.normal))
      ],
    ),
  );
}
