import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        primarySwatch: Colors.purple,
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
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.add,
                size: 30,
              ),
            )
          : null,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
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
    );
  }
}
