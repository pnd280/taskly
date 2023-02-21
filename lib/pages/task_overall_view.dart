import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/filter_utils.dart';
import 'package:taskly/widgets/filter_bar.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/widgets/task_card.dart';

class TaskOverallViewPage extends StatefulWidget {
  const TaskOverallViewPage({super.key});

  @override
  State<TaskOverallViewPage> createState() => _TaskOverallViewPageState();
}

class _TaskOverallViewPageState extends State<TaskOverallViewPage> {
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
      case 2:
        updateFinalFormattedTasks(
          newFormattedList: filterTasks(
            tasks: placeholderTasks,
            sortType: 2,
            showCompleted: true,
          ),
        );
        break;
      default:
        updateFinalFormattedTasks(
            newFormattedList: filterTasks(
                tasks: placeholderTasks, sortType: currentChosenTag));
        break;
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
                            ? (finalFormattedTasks.asMap().entries.map(
                                (entry) {
                                  if (entry.value.isEmpty) {
                                    return Container();
                                  }
                                  return TaskCluster(
                                      // DateTime.parse(uniqueDays.toList()[entry.key]),
                                      entry.value[0]['beginAt'] ??
                                          entry.value[0]['createdAt'],
                                      entry.value,
                                      primaryColor);
                                },
                              ).toList())
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
}
