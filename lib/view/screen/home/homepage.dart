import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/controllers/profile_provider.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/drawer/bottomNavigationBar.dart';
import 'package:jobchat/view/screen/home/alljobs.dart';
import 'package:jobchat/view/screen/home/popularJobs.dart';
import 'package:jobchat/view/screen/profile/profile.dart';
import 'package:provider/provider.dart';
import 'package:jobchat/models/job.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    var loginNotfier = Provider.of<LoginNotifier>(context);
    loginNotfier.getData();
    return Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
      return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.white,
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.grey.withOpacity(0.5),
                          )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      homeAppBar(
                          userNameConst, profileNotifier.profileImage, context),
                      searchCard(),
                      tagList(
                        selected: loginNotfier.selected,
                      ),
                      loginNotfier.selected == 0
                          ? const allJobWidget()
                          : loginNotfier.selected == 1
                              ? const popularJobs()
                              : Container(),
                    ],
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: accentColor,
            elevation: 0,
            onPressed: () {
              var zoomDrawer = ZoomDrawer.of(context);
              zoomDrawer!.toggle();
            },
            shape: const CircleBorder(),
            child: const Icon(
              Icons.menu_outlined,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: const bottomNavigationBar());
    });
  }
}

Widget homeAppBar(String username, String profile, BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 35, left: 20, right: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            reusableText(
                text: "Welcome Home",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
            reusableText(
                text: username == '' ? "Login to Apply Job" : username,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontSize: 28))
          ],
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, right: 25),
              transform: Matrix4.rotationZ(100),
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  Positioned(
                      top: 0,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      )),
                  const SizedBox(
                    width: 40,
                  )
                ],
              ),
            ),
            circularAvtr(image: profile, width: 50, height: 50)
          ],
        )
      ],
    ),
  );
}

Widget searchCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
    height: 300,
    width: double.maxFinite,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
            image: AssetImage('assets/images/search_bg.png'),
            fit: BoxFit.cover)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        reusableText(
            text: "Fast Search",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 10,
        ),
        const Text("You can seach quickly for\nthe job you want",
            style: TextStyle(
                color: Colors.white, height: 1.8, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 30,
        ),
        searchBar()
      ],
    ),
  );
}

Widget searchBar() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/search.png',
            width: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Search',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          )
        ],
      ),
    ),
  );
}

class tagList extends StatefulWidget {
  tagList({super.key, required int selected});
  int? selected;

  @override
  State<tagList> createState() => _tagListState();
}

class _tagListState extends State<tagList> {
  final tagList = <String>["All", "⚡ Recent", "⭐ BookMarked"];
  @override
  Widget build(BuildContext context) {
    var loginNotfier = Provider.of<LoginNotifier>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                loginNotfier.change(index);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                decoration: BoxDecoration(
                    color: loginNotfier.selected == index
                        ? primaryColor.withOpacity(0.2)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: loginNotfier.selected == index
                            ? primaryColor
                            : primaryColor.withOpacity(0.2))),
                child: Text(tagList[index]),
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

// job tile foreach job
class jobTile extends StatefulWidget {
  const jobTile(
      {super.key,
      required this.job,
      required this.showTime,
      required this.bookmarked});

  final Job job;

  final bool showTime;
  final bool bookmarked;

  @override
  State<jobTile> createState() => _jobTileState();
}

class _jobTileState extends State<jobTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white),
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
                  const SizedBox(width: 70),
                ],
              ),
              Icon(
                  widget.bookmarked
                      ? Icons.bookmark
                      : Icons.bookmark_outline_outlined,
                  color: widget.bookmarked ? primaryColor : Colors.black)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
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
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(widget.job.location, Icons.location_on_outlined,
                  Colors.yellow),
              if (widget.showTime)
                iconText(widget.job.contract, Icons.access_time_outlined,
                    Colors.yellow)
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

class BookMarkTile extends StatelessWidget {
  BookMarkTile(
      {super.key,
      required this.imageUrl,
      required this.company,
      required this.contract,
      required this.location,
      required this.title,
      required this.agentName,
      required this.bookmarked,
      required this.showTime});
  String imageUrl;
  String company;
  String contract;
  String location;
  String title;
  String agentName;
  bool bookmarked;
  bool showTime;

  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white),
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
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    company,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 70),
                ],
              ),
              Icon(
                  bookmarked ? Icons.bookmark : Icons.bookmark_outline_outlined,
                  color: bookmarked ? primaryColor : Colors.black)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            agentName,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.8)),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(location, Icons.location_on_outlined, Colors.yellow),
              if (showTime)
                iconText(contract, Icons.access_time_outlined, Colors.yellow)
            ],
          )
        ],
      ),
    );
  }
}
