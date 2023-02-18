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

  List<Widget> pages = [
    TaskOverallViewPage(),
    CalendarViewPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentNavPage],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: currentNavPage,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Task'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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
