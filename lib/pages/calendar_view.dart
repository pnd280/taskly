import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/miscs/filter_utils.dart';
import 'package:taskly/miscs/styles.dart';
import 'package:taskly/miscs/utils.dart';
import 'package:taskly/pages/task_editor.dart';
import 'package:taskly/widgets/filter_bar.dart';
import 'dart:developer';

class CalendarViewPage extends StatefulWidget {
  int view;

  CalendarViewPage({super.key, this.view = 0});

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  DateTime currentCalendarPage = DateTime.now();

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

    // remove all events
    final allEvents = CalendarControllerProvider.of(context).controller.events;
    for (var event in allEvents) {
      CalendarControllerProvider.of(context).controller.remove(event);
    }

    // load event to calendar
    for (var tasks in finalFormattedTasks) {
      for (var task in tasks) {
        // create a map<string, string> that contains all the task info
        // and convert it to a string

        final event = CalendarEventData(
          title: task['title'],
          date: task['beginAt'] ?? task['createdAt'],
          endDate: task['endAt'],
          startTime: task['beginAt'] ?? task['createdAt'],
          endTime: task['endAt'],
          description: task['rich_description'] != null
              ? removeHtmlTags(task['rich_description'])
              : '',
        );
        // calendarController.add(event);
        CalendarControllerProvider.of(context).controller.add(event);
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Container(),
          FilterBar(
              tags: dummyTags,
              userTags: dummyUserTags,
              currentChosenTag: currentChosenTag,
              currentChosenDropdownItem: currentChosenDropdownItem,
              dropdownOnTap: dropdownOnTap,
              primaryColor: primaryColor,
              tagOnTap: tagOnTap),
          Expanded(
            child: CalendarView(widget.view),
          ),
        ],
      ),
    );
  }

  Widget CalendarView(int view) {
    GlobalKey<MonthViewState> calendarMonthViewKey =
        GlobalKey<MonthViewState>();
    GlobalKey<DayViewState> calendarDayViewKey = GlobalKey<DayViewState>();
    GlobalKey<DayViewState> calendarWeekViewKey = GlobalKey<DayViewState>();

    switch (view) {
      case 0:
        return MonthView(
          // controller: calendarController,
          initialMonth: currentCalendarPage,
          onPageChange: (date, page) {
            setState(() {
              currentCalendarPage = date;
            });
          },
          key: calendarMonthViewKey,
          showBorder: false,
          weekDayBuilder: (day) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    // color: TasklyColor.VeriPeri,
                    ),
                child: Center(
                  child: Text(
                    intToWeekDay(day),
                    style: const TextStyle(
                      color: TasklyColor.greyText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
          onCellTap: (events, date) {},
          onEventTap: (event, date) {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (buildContext) {
            //   return TaskEditorPage(
            //     task: json.decode(event.description),
            //   );
            // }));

            // show a dialog that contains the task title and rich description
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(event.title),
                  content: Text(event.description),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        );
      case 1:
        return DayView(
          initialDay: currentCalendarPage,
          onPageChange: (date, page) {
            setState(() {
              currentCalendarPage = date;
            });
          },
          key: calendarDayViewKey,
          heightPerMinute: 1,
          eventTileBuilder:
              (date, events, boundary, startDuration, endDuration) {
            // maintain the same design but change the background color to TasklyColor.VeriPeri
            return Container(
              decoration: const BoxDecoration(
                color: TasklyColor.VeriPeri,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  for (var event in events)
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: TasklyColor.VeriPeri,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [TasklyStyle.shadow]),
                        child: ListTile(
                          title: Text(
                            event.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            event.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          onEventTap: (events, date) {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (buildContext) {
            //   return TaskEditorPage(
            //     task: json.decode(event.description),
            //   );
            // }));

            // show a dialog that contains the task title and rich description
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(events[0].title),
                  content: Text(events[0].description),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        );
      case 2:
        return WeekView(
          eventTileBuilder:
              (date, events, boundary, startDuration, endDuration) {
            // maintain the same design but change the background color to TasklyColor.VeriPeri
            return Container(
              decoration: const BoxDecoration(
                color: TasklyColor.VeriPeri,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  for (var event in events)
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: TasklyColor.VeriPeri,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [TasklyStyle.shadow]),
                        child: ListTile(
                          title: Text(
                            event.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            event.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          key: calendarWeekViewKey,
          initialDay: currentCalendarPage,
          onPageChange: (date, page) {
            setState(() {
              currentCalendarPage = date;
            });
          },
          onEventTap: (events, date) {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (buildContext) {
            //   return TaskEditorPage(
            //     task: json.decode(event.description),
            //   );
            // }));

            // show a dialog that contains the task title and rich description
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(events[0].title),
                  content: Text(events[0].description),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        );
      default:
        return const MonthView();
    }
  }
}
