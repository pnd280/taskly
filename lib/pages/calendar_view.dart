import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class CalendarViewPage extends StatefulWidget {
  int view;

  CalendarViewPage({super.key, this.view = 0});

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.view.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: (widget.view == 0) ? MonthView() : DayView(),
    );
  }
}
