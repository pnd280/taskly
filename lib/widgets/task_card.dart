import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:intl/intl.dart';

Widget TaskCluster(DateTime dateTime, List<Map> tasks, Color borderColor) {
  // Sort tasks based on priority key
  tasks.sort((a, b) => a['priority'].compareTo(b['priority']));

  return ListView(
    // clipBehavior: Clip.none,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat("EEE, MMM d").format(dateTime),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...(tasks.map((e) => TaskCard(e, borderColor)).toList()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat("EEE, MMM d").format(dateTime),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...(tasks.map((e) => TaskCard(e, borderColor)).toList())
        ],
      ),
    ],
  );
}
// TODO: change to flutter_slidable
Widget TaskCard(Map task, Color borderColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        // boxShadow: const [
        //   TasklyStyle.shadow,
        // ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: IconButton(
                        icon: const Icon(Icons.circle_outlined, color: TasklyColor.VeriPeri,), onPressed: () {}),
                  ), // checkbox
                  Text(
                    task['title'],
                    style: const TextStyle(),
                  ),
                ],
              ),
            ),
          ), // title
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.clock,
                  size: 18,
                ),
                Text(
                  TimeOfDay.fromDateTime(task['beginAt'])
                      .toString()
                      .substring(10, 15),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
