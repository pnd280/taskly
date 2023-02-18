import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/widgets/tag.dart';

final List dummyTags = [
  'All',
  'In Progress',
  'Completed',
  'Todo',
];
final List<String> dummyUserTags = <String>[
  'Custom tags',
  'Personal',
  'Work',
  'Shopping'
];

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
            child: SizedBox(
              width: double.infinity,
              height: 38,
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: dummyTags.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: (index <= dummyTags.length - 1)
                        ? Tag(dummyTags[index], primaryColor, index, tagOnTap,
                            currentChosenTag == index ? true : false)
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: (currentChosenTag < 0)
                                  ? primaryColor
                                  : Colors.grey.withOpacity(.2),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: currentChosenDropdownItem,
                                dropdownColor: (currentChosenTag < 0)
                                    ? primaryColor
                                    : Colors.white,
                                icon: Icon(
                                  CupertinoIcons.chevron_down,
                                  color: (currentChosenTag < 0)
                                      ? Colors.white
                                      : primaryColor,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    currentChosenTag = -1;
                                    currentChosenDropdownItem = value!;
                                  });
                                },
                                items: dummyUserTags
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
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
                          ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Placeholder(),
            ),
          ),
        ],
      ),
    );
  }
}
