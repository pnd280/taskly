import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/miscs/filter_utils.dart';
import 'package:taskly/miscs/utils.dart';
import 'package:taskly/widgets/filter_bar.dart';
import 'dart:developer';

class CalendarViewPage extends StatefulWidget {
  int view;

  CalendarViewPage({super.key, this.view = 0});

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
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
        final event = CalendarEventData(
          title: task['title'],
          date: task['beginAt'] ?? task['createdAt'],
          endDate: task['endAt'],
          startTime: task['beginAt'] ?? task['createdAt'],
          endTime: task['endAt'],
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
            print(event.title);
            print(date);
          },
        );
      case 1:
        return DayView(
          key: calendarDayViewKey,
          heightPerMinute: 1,
          // fullDayEventBuilder: (events, date) {
          //   return Container(
          //     decoration: BoxDecoration(
          //       color: Colors.blue,
          //     ),
          //   );
          // },
        );
      case 2:
        return WeekView(
          key: calendarWeekViewKey,
        );
      default:
        return const MonthView();
    }
  }
}
