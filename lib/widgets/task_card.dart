import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:intl/intl.dart';
import 'package:taskly/pages/task_editor.dart';

Widget TaskCluster(
  DateTime? dateTime,
  List tasks,
  Color borderColor,
  parentContext,
  forceRedrawCallback,
) {
  // Sort tasks based on priority key
  // tasks.sort((a, b) => a['priority'].compareTo(b['priority']));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: dateTime == null
            ? const Text('No date')
            : Text(
                DateFormat("EEE, MMM d").format(dateTime),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      ...(tasks.map((e) => TaskCard(e, borderColor, parentContext)).toList()),
    ],
  );
}

// TODO: change to flutter_slidable
Widget TaskCard(Map task, Color borderColor, context) {
  return GestureDetector(
    onTap: () {
      log('${task['title']} -> view/edit');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskEditorPage(
            task: task,
          ),
        ),
      );
    },
    child: Padding(
      // key: Key(task['id']),
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
                          icon: task['isCompleted']
                              ? const Icon(
                                  Icons.check_circle,
                                  color: TasklyColor.VeriPeri,
                                )
                              : const Icon(
                                  Icons.circle_outlined,
                                  color: TasklyColor.VeriPeri,
                                ),
                          onPressed: () {
                            // if (task['isCompleted']) {
                            //   return;
                            // }
                            // find and replace isCompleted field on placeholderTasks
                            placeholderTasks[placeholderTasks.indexWhere(
                                    (element) => element['id'] == task['id'])]
                                ['isCompleted'] = !task['isCompleted'];
                            // debug all tasks completion/uncompletion
                            log(placeholderTasks
                                .map((e) => e['id'])
                                .toList()
                                .toString());
                            forceRedrawCb_();
                          }),
                    ), // checkbox
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['title'],
                          style: const TextStyle(),
                        ),
                        task['projectId'] != null
                            ? Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.tags_solid,
                                    size: 15,
                                    color: TasklyColor.VeriPeri,
                                  ),
                                  Text(
                                    task['projectId'],
                                    style: const TextStyle(),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ), // title
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: task['beginAt'] == null
                    ? []
                    : [
                        const Icon(
                          CupertinoIcons.clock,
                          size: 18,
                        ),
                        Text(
                          TimeOfDay.fromDateTime(task['beginAt'])
                              .toString()
                              .substring(10, 15),
                        ),
                      ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
