import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/searchNotifer.dart';

import 'package:jobchat/models/job.dart';
import 'package:jobchat/view/common/NoSearchResult.dart';
import 'package:jobchat/view/screen/home/homepage.dart';
import 'package:jobchat/view/screen/job/fullJobView.dart';

import 'package:provider/provider.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var searchNotifier = Provider.of<searchNotifer>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    color: primaryColor.withOpacity(0.1),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: primaryColor.withOpacity(0.1),
                  ))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const searchAppBar(),
              searchInput(
                controller: controller,
              ),
              tagList(
                selected: searchNotifier.selected,
                controller: controller,
              ),
              controller.text.isNotEmpty
                  ? Expanded(
                      child: FutureBuilder<List<Job>>(
                          future: searchNotifier.searchedJobs,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            } else if (snapshot.hasError) {
                              return Text("Error: +${snapshot.error}");
                            } else if (snapshot.data!.isEmpty) {
                              return const NoSearchResults(
                                  message: "No Jobs Found");
                            } else {
                              final job = snapshot.data!.reversed.toList();
                              return Container(
                                margin: const EdgeInsets.only(top: 25),
                                child: ListView.separated(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    itemCount: job.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    separatorBuilder: (_, index) =>
                                        const SizedBox(
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
                                          child: jobTile(
                                              job: mJob,
                                              showTime: true,
                                              bookmarked: true));
                                    }),
                              );
                            }
                          }),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 90),
                      child: const NoSearchResults(
                          message: "Start Searching.....")),
            ],
          )
        ],
      ),
    );
  }
}

class searchAppBar extends StatefulWidget {
  const searchAppBar({super.key});

  @override
  State<searchAppBar> createState() => _searchAppBarState();
}

class _searchAppBarState extends State<searchAppBar> {
  // MediaQuery.of(context).padding.top to get the height of status bar
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: primaryColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 20),
                  transform: Matrix4.rotationZ(100),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications_none_outlined,
                        size: 30,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          )),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Icon(Icons.more_horiz_outlined,
                    size: 20, color: Colors.black.withOpacity(0.7))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class searchInput extends StatefulWidget {
  searchInput({super.key, required this.controller});
  TextEditingController controller;

  @override
  State<searchInput> createState() => _searchInputState();
}

class _searchInputState extends State<searchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              cursorColor: accentColor,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  hintText: "Search Job",
                  hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      var searchNotifier =
                          Provider.of<searchNotifer>(context, listen: false);
                      if (widget.controller.text.isNotEmpty) {
                        searchNotifier.search(widget.controller.text);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/icons/search.png',
                        color: Colors.black,
                        width: 20,
                      ),
                    ),
                  )),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: accentColor, borderRadius: BorderRadius.circular(25)),
            child: Image.asset('assets/icons/filter.png'),
          )
        ],
      ),
    );
  }
}

class tagList extends StatefulWidget {
  tagList({super.key, required int selected, required this.controller});
  int? selected;
  TextEditingController controller;

  @override
  State<tagList> createState() => _tagListState();
}

class _tagListState extends State<tagList> {
  final tagList = <String>[
    "SDE",
    "Analytics",
    "Development",
    "Java",
    "AI",
    "ML",
    "React",
    "Flutter"
  ];
  @override
  Widget build(BuildContext context) {
    var searchNotifier = Provider.of<searchNotifer>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                searchNotifier.change(index);
                searchNotifier.search(tagList[index]);
                widget.controller.text = tagList[index];
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                decoration: BoxDecoration(
                    color: searchNotifier.selected == index
                        ? primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: searchNotifier.selected == index
                            ? primaryColor
                            : primaryColor.withOpacity(0.2))),
                child: Row(
                  children: [
                    Text(
                      tagList[index],
                      style: TextStyle(
                          color: searchNotifier.selected == index
                              ? Colors.white
                              : Colors.black),
                    ),
                    const SizedBox(width: 10),
                    if (searchNotifier.selected == index)
                      GestureDetector(
                        onTap: () {
                          searchNotifier.change(-1);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                      )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
                width: 15,
              ),
          itemCount: tagList.length),
    );
  }
}
