import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/utils.dart';

GlobalKey<MonthViewState> _calendarMonthViewKey = GlobalKey<MonthViewState>();
GlobalKey<DayViewState> _calendarDayViewKey = GlobalKey<DayViewState>();

class CalendarViewPage extends StatefulWidget {
  int view;

  CalendarViewPage({super.key, this.view = 0});

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CalendarView(widget.view),
    );
  }

  // widget CalendarView returns a widget that displays a calendar (month, day)
  Widget CalendarView(int view) {
    switch (view) {
      case 0:
        return MonthView(
          key: _calendarMonthViewKey,
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
          onCellTap: (events, date) {
            
          },
        );
      case 1:
        return DayView(
          key: _calendarDayViewKey,
        );
      default:
        return const MonthView();
    }
  }
}
