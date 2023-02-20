
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/dummies.dart';
import 'package:taskly/miscs/utils.dart';
import 'package:taskly/widgets/filter_bar.dart';

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


    void viewNextPage() {
      MonthViewState().nextPage();
    }

    DateTime selectedDate = DateTime.now();

    switch (view) {
      case 0:
        return MonthView(
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
          onCellTap: (events, date) {
            // debugPrint(MonthViewState().toString());
            calendarMonthViewKey.currentState!.nextPage();
          },
        );
      case 1:
        return DayView(
          key: calendarDayViewKey,
        );
      default:
        return const MonthView();
    }
  }
}