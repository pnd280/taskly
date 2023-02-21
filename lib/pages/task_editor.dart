import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/miscs/styles.dart';
import 'package:taskly/widgets/color_picker.dart';
import 'package:taskly/widgets/custom_snackbar.dart';
import 'package:taskly/widgets/date_picker.dart';
import 'package:taskly/widgets/rich_editor.dart';

import '../widgets/custom_text_field.dart';

class TaskEditorPage extends StatefulWidget {
  bool isNewTask;

  TaskEditorPage({
    super.key,
    this.isNewTask = true,
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

  String richDescription = '';

  Color pickerColor = TasklyColor.VeriPeri;
  Color currentColor = TasklyColor.VeriPeri;

  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Container(
        color: Colors.transparent,
        child: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    splashRadius: 25,
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        scrollController
                            .jumpTo(scrollController.position.maxScrollExtent);
                      });
                    },
                    icon: const Icon(
                      CupertinoIcons.trash,
                    ),
                  ),
                ),
                IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    Map _task = {
                      'color': currentColor,
                      'title': title,
                      'startDate': startDate,
                      'startTime': startTime,
                      'endDate': endDate,
                      'endTime': endTime,
                      'rich_description': richDescription
                    };
                    debugPrint('Map Contents:');
                    _task.forEach((key, value) {
                      debugPrint('$key: $value');
                    });
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.checkmark_alt,
                  ),
                )
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: ColorPickerCluster(
                            onColorChange: changeColor,
                          ),
                        ),
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
                                  initialValue: '',
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
                                await _selectDate(
                                  context,
                                  startDate,
                                  (value) {
                                    setState(() {
                                      startDate = value;
                                    });
                                  },
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
                                await _selectDate(
                                  context,
                                  startDate,
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
                              await _selectTime(
                                context,
                                startTime,
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
                      ),
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
      BuildContext context, DateTime? selectedDate, onUpdateCallback) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2010),
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
