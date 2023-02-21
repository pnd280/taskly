import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskly/db_test.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/widgets/filter_bar.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/widgets/task_card.dart';

class TaskOverallViewPage extends StatefulWidget {
  const TaskOverallViewPage({super.key});

  @override
  State<TaskOverallViewPage> createState() => _TaskOverallViewPageState();
}

class _TaskOverallViewPageState extends State<TaskOverallViewPage> {
  Set uniqueDays = {};
  List<List> finalFormattedTasks = [[]];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    void tagOnTap(int index) {
      setState(() {
        currentChosenTag = index;
      });
    }

    void updateFinalFormattedTasks({required List<List> newFormattedList}) {
      setState(() {
        finalFormattedTasks = newFormattedList;
      });
    }

    switch (currentChosenTag) {
      case 0:
        updateFinalFormattedTasks(
            newFormattedList: sortByScheduleAt(placeholderTasks));
        break;
      case 1:
        // setState(() {
        //   finalFormattedTasks = [];
        // });

        // for testing purpose
        List<List> emptyList = [
          [
            {
              'id': '1',
              'title': 'Attend daily standup meeting',
              'rich_description': 'Discuss progress and blockers with the team',
              'createdAt': DateTime(2023, 2, 25, 9, 0),
              'beginAt': null,
              'endAt': null,
              'repeat': false,
              'priority': 1,
              'isCompleted': false,
              'projectId': 'work',
              'isVisible': true,
            },
          ]
        ];
        updateFinalFormattedTasks(newFormattedList: emptyList);
        break;
      case 2:
        dbHelper();
        break;
      default:
    }

    void dropdownOnTap(String? value) {
      setState(() {
        currentChosenTag = -1;
        currentChosenDropdownItem = value!;
        debugPrint(value);
      });
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: TasklyGradient.lightBackground,
        ),
        child: Column(
          children: [
            FilterBar(
                tags: dummyTags,
                userTags: dummyUserTags,
                currentChosenTag: currentChosenTag,
                currentChosenDropdownItem: currentChosenDropdownItem,
                dropdownOnTap: dropdownOnTap,
                primaryColor: primaryColor,
                tagOnTap: tagOnTap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: finalFormattedTasks.isNotEmpty
                            ? (finalFormattedTasks
                                .asMap()
                                .entries
                                .map(
                                  (entry) => TaskCluster(
                                      // DateTime.parse(uniqueDays.toList()[entry.key]),
                                      entry.value[0]['beginAt'] ??
                                          entry.value[0]['createdAt'],
                                      entry.value,
                                      primaryColor),
                                )
                                .toList())
                            : [],
                      ),
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

  List<List> sortByScheduleAt(tasks) {
    for (var task in tasks) {
      dynamic beginAt = task['beginAt'];
      if (task['beginAt'] == null) {
        beginAt = task['createdAt'];
      }
      uniqueDays.add(DateFormat('yyyy-MM-dd').format(beginAt));
    }

    var sortedDay = uniqueDays.toList()..sort((a, b) => a.compareTo(b));

    List<List> ret = [];

    for (var day in sortedDay) {
      var taskList = [];
      for (var task in tasks) {
        dynamic beginAt = task['beginAt'];
        if (task['beginAt'] == null) {
          beginAt = task['createdAt'];
        }

        var formattedBeginAt = DateFormat('yyyy-MM-dd').format(beginAt);

        if (formattedBeginAt == day) {
          // dev.log(task.toString());
          if (!task['isVisible']) continue;
          taskList.add(task);
        }
      }
      ret.add(taskList);
    }

    return ret;
  }
}
