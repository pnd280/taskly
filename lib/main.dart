import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/pages/calendar_view.dart';
import 'package:taskly/pages/settings.dart';
import 'package:taskly/pages/task_overall_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.purple,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  int currentNavPage = 0;

  List<Widget> pages = const [
    TaskOverallViewPage(),
    CalendarViewPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentNavPage],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: currentNavPage != 2
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.add,
                size: 30,
              ),
            )
          : Container(),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: currentNavPage,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Task'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (int index) {
            setState(() {
              currentNavPage = index;
            });
          },
        ),
      ),
    );
  }
}
