import 'package:flutter/material.dart';
import 'package:jobchat/view/common/jobsVerticaltTiles.dart';

class recentList extends StatefulWidget {
  const recentList({super.key});

  @override
  State<recentList> createState() => _recentListState();
}

// horizontal scroll view need height fixed but not for Vertical Scroll
class _recentListState extends State<recentList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return const Padding(
              padding: EdgeInsets.only(bottom: 3.0), child: JobsVerticalTile());
        });
  }
}
