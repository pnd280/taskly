import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/miscs/styles.dart';
import 'package:taskly/miscs/utils.dart';
import 'package:taskly/pages/task_overall_view.dart';
import 'package:taskly/widgets/color_picker.dart';
import 'package:taskly/widgets/custom_snackbar.dart';
import 'package:taskly/widgets/date_picker.dart';
import 'package:taskly/widgets/rich_editor.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer';

import '../widgets/custom_text_field.dart';

class TaskEditorPage extends StatefulWidget {
  Map? task;

  TaskEditorPage({
    super.key,
    this.task,
  });

  @override
  State<TaskEditorPage> createState() => _TaskEditorPageState();
}

class _TaskEditorPageState extends State<TaskEditorPage> {
  String? title;

  DateTime? startDate;
  DateTime? endDate;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  String? richDescription;

  Color pickerColor = TasklyColor.VeriPeri;
  Color currentColor = TasklyColor.VeriPeri;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  bool inputEnabled = true;

  void changeToEditingMode() {
    setState(() {
      title = null;
      inputEnabled = true;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      print('widget.task = ${widget.task}');

      title = widget.task!['title'];
      startDate = widget.task!['beginAt'];
      endDate = widget.task!['endAt'];
      startTime = widget.task!['beginAt'] != null
          ? TimeOfDay.fromDateTime(widget.task!['beginAt'])
          : null;
      endTime = widget.task!['endAt'] != null
          ? TimeOfDay.fromDateTime(widget.task!['endAt'])
          : null;

      richDescription = widget.task!['rich_description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Container(
        color: Colors.transparent,
        child: Scaffold(
            appBar: AppBar(
              actions: [
                widget.task != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          splashRadius: 25,
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  content: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: const Text('Delete this task?'),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        placeholderTasks.removeWhere((task) =>
                                            task['id'] == widget.task!['id']);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        forceRedrawCb_();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.trash,
                          ),
                        ),
                      )
                    : Container(),
                // widget.task == null
                // ?
                IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    if (widget.task == null) {
                      if (title == null || title!.isEmpty) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              content: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                              title: const Text('Please enter a title'),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }

                      // check start date and time and end date and time, if start date and time is after end date and time, then show a dialog
                      if (startDate != null &&
                          endDate != null &&
                          startTime != null &&
                          endTime != null) {
                        if (joinDateTimeAndTimeOfDay(startDate!, startTime!)
                                .isAfter(joinDateTimeAndTimeOfDay(
                                    endDate!, endTime!)) ||
                            joinDateTimeAndTimeOfDay(startDate!, startTime!) ==
                                joinDateTimeAndTimeOfDay(endDate!, endTime!)) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                content: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                                title: const Text('Invalid time range'),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                      }

                      Map<String, dynamic> task = {
                        // ignore: prefer_const_constructors
                        'id': Uuid(),
                        'title': title != null && title!.isNotEmpty
                            ? title
                            : 'Untitled',
                        'rich_description': richDescription ?? '',
                        'createdAt': DateTime.now(),
                        'beginAt':
                            joinDateTimeAndTimeOfDay(startDate, startTime),
                        'endAt': joinDateTimeAndTimeOfDay(endDate, endTime),
                        'isCompleted': false,
                        'isVisible': true,
                        // 'color': currentColor.value.toRadixString(16).padLeft(8, '0'),
                        // 'startDate': startDate,
                        // 'startTime': startTime,
                        // 'endDate': endDate,
                        // 'endTime': endTime,
                      };

                      // log(json.encode(_task));
                      // log(Color(int.parse('ff8672ef', radix: 16)).toString());

                      placeholderTasks.add(task);

                      Navigator.of(context).pop();

                      forceRedrawCb_();
                      return;
                    }

                    // if any of the fields are changed from the initial value, then prompt user to save changes by showing a cupertino dialog
                    if (title != widget.task!['title'] ||
                        richDescription != widget.task!['rich_description'] ||
                        startDate != widget.task!['beginAt'] ||
                        endDate != widget.task!['endAt'] ||
                        startTime !=
                            TimeOfDay.fromDateTime(widget.task!['beginAt']) ||
                        endTime !=
                            TimeOfDay.fromDateTime(widget.task!['endAt'])) {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            content: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                            title: const Text('Save changes?'),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Discard'),
                              ),
                              CupertinoDialogAction(
                                onPressed: () {
                                  if (startDate != null && startTime == null) {
                                    startTime =
                                        const TimeOfDay(hour: 0, minute: 0);
                                  }

                                  if (endDate != null && endTime == null) {
                                    endTime =
                                        const TimeOfDay(hour: 0, minute: 0);
                                  }

                                  Map<String, dynamic> updatedTask = {
                                    // list all the fields that can be changed
                                    'id': widget.task!['id'],
                                    'title': title != null && title!.isNotEmpty
                                        ? title
                                        : 'Untitled',
                                    'rich_description': richDescription ?? '',
                                    'createdAt': widget.task!['createdAt'],
                                    'beginAt':
                                        startDate != null && startTime != null
                                            ? joinDateTimeAndTimeOfDay(
                                                startDate, startTime)
                                            : null,
                                    'endAt': endDate != null && endTime != null
                                        ? joinDateTimeAndTimeOfDay(
                                            endDate, endTime)
                                        : null,
                                    'isCompleted': widget.task!['isCompleted'],
                                    'isVisible': widget.task!['isVisible'],
                                  };

                                  // log updatedTask
                                  log((updatedTask).toString());

                                  int taskIndex = placeholderTasks.indexWhere(
                                      (t) => t['id'] == widget.task!['id']);
                                  if (taskIndex != -1) {
                                    placeholderTasks[taskIndex] = updatedTask;
                                  }

                                  log('task updated!');
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  forceRedrawCb_();
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    log('no changes made');
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.checkmark_alt,
                  ),
                )
                // : IconButton(
                //     splashRadius: 25,
                //     onPressed: () {
                //       changeToEditingMode();
                //     },
                //     icon: const Icon(Icons.edit),
                //   )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 20.0),
                        //   child: ColorPickerCluster(
                        //     onColorChange: changeColor,
                        //   ),
                        // ),
                        Expanded(
                          child: ShadowBoxWithTitle(
                            title: 'Title',
                            child: [
                              Expanded(
                                child: InputField(
                                  updateCallBack: (value) {
                                    setState(() {
                                      title = value;
                                    });
                                  },
                                  initialValue: title,
                                  enabled: inputEnabled,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              onTap: () async {
                                if (inputEnabled != true) return;
                                await _selectDate(
                                  context,
                                  startDate,
                                  (value) {
                                    setState(() {
                                      startDate = value;
                                    });
                                  },
                                  startDate ?? DateTime.now(),
                                );
                                debugPrint('Start date: $startDate');
                              },
                              child: ShadowBoxWithTitle(
                                title: 'Start Date',
                                child: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: TasklyColor.greyText,
                                          ),
                                        ),
                                        startDate == null
                                            ? const Text('Select date')
                                            : Text(DateFormat('dd/MM/yy')
                                                .format(startDate!)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (inputEnabled != true) return;

                              await _selectTime(
                                context,
                                startTime,
                                (value) {
                                  setState(() {
                                    startTime = value;
                                  });
                                },
                              );
                              debugPrint('Start time: $startTime');
                            },
                            child: ShadowBoxWithTitle(
                              title: 'Start Time',
                              child: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: TasklyColor.greyText,
                                        ),
                                      ),
                                      startTime == null
                                          ? const Text('Select time')
                                          : Text(DateFormat('hh:mm a').format(
                                              DateTime(
                                                  2020,
                                                  1,
                                                  1,
                                                  startTime!.hour,
                                                  startTime!.minute))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              onTap: () async {
                                if (inputEnabled != true) return;
                                await _selectDate(
                                  context,
                                  endDate ?? startDate,
                                  (value) {
                                    setState(() {
                                      endDate = value;
                                    });
                                  },
                                );
                                debugPrint('End date: $endDate');
                              },
                              child: ShadowBoxWithTitle(
                                title: 'End Date',
                                child: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: TasklyColor.greyText,
                                          ),
                                        ),
                                        endDate == null
                                            ? const Text('Select date')
                                            : Text(DateFormat('dd/MM/yy')
                                                .format(endDate!)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (inputEnabled != true) return;

                              await _selectTime(
                                context,
                                endTime ?? startTime,
                                (value) {
                                  setState(() {
                                    endTime = value;
                                  });
                                },
                              );
                              debugPrint('End time: $endTime');
                            },
                            child: ShadowBoxWithTitle(
                              title: 'Start Time',
                              child: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: TasklyColor.greyText,
                                        ),
                                      ),
                                      endTime == null
                                          ? const Text('Select time')
                                          : Text(DateFormat('hh:mm a').format(
                                              DateTime(
                                                  2020,
                                                  1,
                                                  1,
                                                  endTime!.hour,
                                                  endTime!.minute))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 20.0),
                  //   child: Placeholder(
                  //     child: Text('tags go here'),
                  //   ),
                  // ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        });
                      },
                      child: RichEditor(
                          onUpdateCallBack: (value) {
                            setState(() {
                              richDescription = value;
                            });
                          },
                          context: context,
                          enable: true,
                          text: richDescription),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget ColorPickerCluster({required onColorChange}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: pickerColor,
                  onColorChanged: onColorChange,
                  layoutBuilder: pickerLayoutBuilder,
                  itemBuilder: pickerItemBuilder,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  )),
                  child: const Text('Change'),
                  onPressed: () {
                    setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: ShadowBoxWithTitle(
        title: 'Color',
        child: [
          Row(
            children: [
              Icon(
                Icons.circle,
                color: currentColor,
                size: 25,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  CupertinoIcons.chevron_down,
                  size: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget ShadowBoxWithTitle(
      {required String title, required List<Widget> child}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              title,
              style: const TextStyle(color: TasklyColor.greyText, fontSize: 13),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [TasklyStyle.shadow],
              borderRadius: BorderRadius.circular(11),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, DateTime? selectedDate, onUpdateCallback,
      [DateTime? firstDate]) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2010),
        lastDate: DateTime(2030));
    if (picked != null) {
      onUpdateCallback(picked);
    }
  }

  Future<void> _selectTime(
      BuildContext context, TimeOfDay? selectedTime, onUpdateCallback) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        onUpdateCallback(picked);
      });
    }
  }
}
