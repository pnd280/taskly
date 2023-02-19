import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/widgets/filter_bar.dart';
import 'package:taskly/widgets/tag.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/widgets/task_card.dart';
import '../miscs/colors.dart';

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

    void dropdownOnTap(String? value) {
      setState(() {
        currentChosenTag = -1;
        currentChosenDropdownItem = value!;
        debugPrint(value);
      });
    }

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.05),
      body: Column(
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
                    child: TaskCluster(
                        DateTime.now(), anotherDummyTasks, primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
