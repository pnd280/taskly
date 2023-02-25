import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/styles.dart';

class GroupTaskCard extends StatefulWidget {
  Map task;

  GroupTaskCard({super.key, required this.task});

  @override
  State<GroupTaskCard> createState() => GroupTaskCardState();
}

class GroupTaskCardState extends State<GroupTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TasklyColor.VeriPeri,
        borderRadius: const BorderRadius.all(Radius.circular(11.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.code,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  widget.task['title'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.white.withOpacity(.5),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          CupertinoIcons.calendar_today,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Text(
                        DateFormat('EEE, MMM d').format(widget.task['endAt']),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Colors.lightBlueAccent,
                        size: 18,
                      ),
                    ),
                    Text(
                      '4/5 Tasks',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // make a progress bar with 2 stacked sizedbox
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
