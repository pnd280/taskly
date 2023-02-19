import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/widgets/tag.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/widgets/task_card.dart';
import 'package:intl/intl.dart';
import '../miscs/colors.dart';

class TaskOverallViewPage extends StatefulWidget {
  const TaskOverallViewPage({super.key});

  @override
  State<TaskOverallViewPage> createState() => _TaskOverallViewPageState();
}

class _TaskOverallViewPageState extends State<TaskOverallViewPage> {
  int currentChosenTag = 0;

  String currentChosenDropdownItem = dummyUserTags.first;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    void tagOnTap(int index) {
      setState(() {
        currentChosenTag = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.05),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
            child: SizedBox(
              width: double.infinity,
              height: 39,
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: dummyTags.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: (index <= dummyTags.length - 1)
                          ? Tag(dummyTags[index], primaryColor, index, tagOnTap,
                              currentChosenTag == index ? true : false)
                          : DropdownTag(primaryColor));
                },
              ),
            ),
          ),
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

  Widget DropdownTag(Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TasklyColor.blackText.withOpacity(.1)),
        borderRadius: BorderRadius.circular(11),
        gradient: (currentChosenTag < 0)
            ? TasklyGradient.purpleBackground
            : TasklyGradient.lightBackground,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentChosenDropdownItem,
          dropdownColor: (currentChosenTag < 0) ? primaryColor : Colors.white,
          icon: Icon(
            CupertinoIcons.chevron_down,
            color: (currentChosenTag < 0) ? Colors.white : primaryColor,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              currentChosenTag = -1;
              currentChosenDropdownItem = value!;
              debugPrint(value);
            });
          },
          items: dummyUserTags.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  value,
                  style: (currentChosenTag < 0)
                      ? const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                      : TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
