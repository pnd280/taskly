import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/miscs/styles.dart';
import 'package:taskly/pages/calendar_view.dart';
import 'package:taskly/pages/settings.dart';
import 'package:taskly/pages/task_overall_view.dart';
import 'package:taskly/miscs/colors.dart';

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
        primarySwatch: const MaterialColor(0xFF8672EF, {
          50: Color(0xFFF3F0FE),
          100: Color(0xFFE0D9FD),
          200: Color(0xFFCDB2FA),
          300: Color(0xFFB98BF6),
          400: Color(0xFFA764F2),
          500: Color(0xFF8672EF),
          600: Color(0xFF6B55E6),
          700: Color(0xFF553FD6),
          800: Color(0xFF4029C5),
          900: Color(0xFF2A158F),
        }),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: TasklyColor.blackText),
          bodyMedium: TextStyle(color: TasklyColor.blackText),
          displayLarge: TextStyle(color: TasklyColor.blackText),
          displayMedium: TextStyle(color: TasklyColor.blackText),
          displaySmall: TextStyle(color: TasklyColor.blackText),
          headlineMedium: TextStyle(color: TasklyColor.blackText),
          headlineSmall: TextStyle(color: TasklyColor.blackText),
          titleLarge: TextStyle(color: TasklyColor.blackText),
          titleMedium: TextStyle(color: TasklyColor.blackText),
          titleSmall: TextStyle(color: TasklyColor.blackText),
          bodySmall: TextStyle(color: TasklyColor.blackText),
          labelSmall: TextStyle(color: TasklyColor.blackText),
        ),
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

  int currentCalendarView = 0;

  List<Widget> pages = const [
    TaskOverallViewPage(),
    CalendarViewPage(),
    SettingsPage(),
  ];

  List<String> appBarTitles = [
    'Inbox',
    'Calendar',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          key: Key('page-$currentNavPage'),
          appBarTitles[currentNavPage],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        actions: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: [1].contains(currentNavPage)
                  ? IconButton(
                      splashRadius: 20,
                      icon: Icon(
                        (currentCalendarView == 1
                            ? CupertinoIcons.calendar
                            : Icons.view_timeline_rounded)
                      ),
                      onPressed: () {
                        setState(() {
                          currentCalendarView = currentCalendarView == 0 ? 1 : 0;
                        });
                      },
                    )
                  : null),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: [0, 1].contains(currentNavPage)
                  ? IconButton(
                      splashRadius: 20,
                      icon: const Icon(
                        CupertinoIcons.search,
                      ),
                      onPressed: () {},
                    )
                  : null),
        ],
      ),
      body: pages[currentNavPage],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: [0, 1].contains(currentNavPage)
          ? Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  TasklyStyle.shadow,
                ],
                borderRadius: BorderRadius.circular(999),
              ),
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(
                  CupertinoIcons.add,
                  size: 30,
                ),
              ),
            )
          : null,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            TasklyStyle.shadow,
          ]),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: currentNavPage,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.checkmark_circle),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.calendar),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            onTap: (int index) {
              setState(() {
                currentNavPage = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
