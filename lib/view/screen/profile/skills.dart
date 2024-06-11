import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobchat/constants/app_constants.dart';

import 'package:jobchat/controllers/skills_provider.dart';
import 'package:jobchat/models/auth/add_skills.dart';
import 'package:jobchat/models/auth/skills.dart';
import 'package:jobchat/services/authHelper.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';
import 'package:jobchat/view/screen/profile/addSkills.dart';
import 'package:provider/provider.dart';

class skillWidget extends StatefulWidget {
  const skillWidget({super.key});

  @override
  State<skillWidget> createState() => _skillWidgetState();
}

class _skillWidgetState extends State<skillWidget> {
  TextEditingController skillContrl = TextEditingController();
  late Future<List<Skills>> mySkills;

  @override
  void initState() {
    // TODO: implement initState
    mySkills = getSkill();
    super.initState();
  }

  // get skills from server
  Future<List<Skills>> getSkill() {
    var skillsUser = authHelper.getSkills();
    return skillsUser;
  }

  @override
  Widget build(BuildContext context) {
    var skillNotifier = Provider.of<skillsNotifier>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              reusableText(
                  text: "Skills",
                  style: appStyle(15, Color(kDark.value), FontWeight.w600)),
              Consumer<skillsNotifier>(builder: (context, skillsNotify, child) {
                return skillsNotify.addSkills != true
                    ? GestureDetector(
                        onTap: () {
                          skillsNotify.setSkills = !skillsNotify.addSkills;
                        },
                        child: const Icon(
                          MaterialCommunityIcons.plus_circle_outline,
                          size: 24,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          skillsNotify.setSkills = !skillsNotify.addSkills;
                        },
                        child: const Icon(
                          AntDesign.closecircle,
                          size: 20,
                        ),
                      );
              })
            ],
          ),
        ),
        const heightSpacer(size: 5),
        skillNotifier.addSkills == true
            ? addSkill(
                skill: skillContrl,
                onTap: () async {
                  if (skillContrl.text != "" || skillContrl.text.isNotEmpty) {
                    AddSkill classModel = AddSkill(skill: skillContrl.text);
                    var model = addSkillToJson(classModel);
                    await authHelper.addSkills(model);
                    skillContrl.clear();
                    skillNotifier.setSkills = !skillNotifier.addSkills;
                    mySkills = getSkill();
                  }
                },
              )
            : SizedBox(
                height: 40.w,
                child: FutureBuilder(
                  future: mySkills,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error : ${snapshot.error}");
                    } else {
                      var skills = snapshot.data;
                      return skills!.isEmpty
                          ? Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: reusableText(
                                  text: "Add Skills To Get A job",
                                  style: appStyle(13, Color(kOrange.value),
                                      FontWeight.w500)),
                            )
                          : ListView.builder(
                              itemCount: skills!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var indSkil = skills[index];
                                return GestureDetector(
                                  onLongPress: () {
                                    skillNotifier.setSkillsId = indSkil.id;
                                  },
                                  onDoubleTap: () {
                                    skillNotifier.setSkillsId = '';
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 5.w),
                                    margin: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.w)),
                                        color: Color(kGreen.value)),
                                    child: Row(
                                      children: [
                                        reusableText(
                                            text: indSkil.skill,
                                            style: appStyle(
                                                13,
                                                Color(kDark.value),
                                                FontWeight.w600)),
                                        const widthSpacer(size: 5),
                                        skillNotifier.addSkillsId == indSkil.id
                                            ? GestureDetector(
                                                onTap: () async {
                                                  // delete skill
                                                  await authHelper
                                                      .deleteSkills(indSkil.id);

                                                  skillNotifier.setSkillsId =
                                                      "";
                                                  mySkills = getSkill();
                                                },
                                                child: Icon(
                                                  AntDesign.delete,
                                                  size: 14,
                                                  color: Color(kDark.value),
                                                ),
                                              )
                                            : const SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                );
                              });
                    }
                  },
                ),
              )
      ],
    );
  }
}
