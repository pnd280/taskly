import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskly/db_helper.dart';
import 'package:taskly/db_utils.dart';
import 'package:taskly/globals.dart';
import 'package:taskly/miscs/styles.dart';
import 'package:taskly/miscs/utils.dart';
import 'package:taskly/pages/calendar_view.dart';
import 'package:taskly/pages/overlay.dart';
import 'package:taskly/pages/settings.dart';
import 'package:taskly/pages/task_create.dart';
import 'package:taskly/pages/task_editor.dart';
import 'package:taskly/pages/task_overall_view.dart';
import 'package:taskly/miscs/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AncestorPage();
  }
}

class AncestorPage extends StatefulWidget {
  const AncestorPage({super.key});

  @override
  State<AncestorPage> createState() => AncestorPageState();
}

class AncestorPageState extends State<AncestorPage> {
  void toggleTaskCreatePageCallBack([bool val = true]) {
    setState(() {
      isTaskCreatePageVisible = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: pageController,
      child: MaterialApp(
        title: 'Taskly',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          )),
          dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          )),
          fontFamily: 'Inter',
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent,
          ),
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
        home: Stack(
          children: [
            RootPage(showTaskCreatePageCallBack: toggleTaskCreatePageCallBack),
            Visibility(
              visible: isTaskCreatePageVisible,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isTaskCreatePageVisible = false;
                  });
                },
                child: const OverlayPage(),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Visibility(
                visible: isTaskCreatePageVisible,
                child: TaskCreatePage(
                  toggleTaskCreatePageCallBack: toggleTaskCreatePageCallBack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  final Function showTaskCreatePageCallBack;

  const RootPage({super.key, required this.showTaskCreatePageCallBack});

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  List pages = [
    const TaskOverallViewPage(),
    null,
    const SettingsPage(),
  ];

  CalendarViewPage loadCalendarView(int view) {
    return CalendarViewPage(
      view: view,
    );
  }

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
                            ? Icons.calendar_view_day_outlined
                            : (currentCalendarView == 2
                                ? Icons.calendar_view_week
                                : CupertinoIcons.calendar)),
                      ),
                      onPressed: () {
                        setState(() {
                          currentCalendarView = currentCalendarView == 0
                              ? 1
                              : (currentCalendarView == 1 ? 2 : 0);
                        });
                      },
                    )
                  : null),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: [0, 1].contains(currentNavPage)
                  ? IconButton(
                      key: const Key('search-icon'),
                      splashRadius: 20,
                      icon: const Icon(
                        CupertinoIcons.search,
                      ),
                      onPressed: () async {
                        var allTasks = await TaskDatabaseHelper.getAllTasks();
                        log(allTasks.toString());

                        log('forced!!!!!!!');
                        placeholderTasks =
                            await TaskDatabaseHelper.getAllTasks();
                        log(placeholderTasks.toString());

                        // convert beginAt, endAt, createdAt to DateTime
                        placeholderTasks = placeholderTasks.map((e) {
                          e['beginAt'] = e['beginAt'] != null
                              ? DateTime.parse(e['beginAt'])
                              : null;
                          e['endAt'] = e['endAt'] != null
                              ? DateTime.parse(e['endAt'])
                              : null;
                          e['createdAt'] = e['createdAt'] != null
                              ? DateTime.parse(e['createdAt'])
                              : null;
                          return e;
                        }).toList();

                        // await TaskDatabaseHelper.deleteAllTasks();

                        // final db = await openDatabase('app.db');

                        // // close the database before deleting the file
                        // await db.close();

                        // // delete the database file
                        // await deleteDatabase('app.db');
                      },
                    )
                  : IconButton(
                      key: const Key('profile-icon'),
                      splashRadius: 20,
                      icon: const Icon(
                        CupertinoIcons.profile_circled,
                      ),
                      onPressed: () {},
                    )),
        ],
      ),
      body: [0, 2].contains(currentNavPage)
          ? pages[currentNavPage]
          : loadCalendarView(currentCalendarView),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: [0, 1].contains(currentNavPage)
          ? Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  TasklyStyle.shadow,
                ],
                borderRadius: BorderRadius.circular(999),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  // widget.showTaskCreatePageCallBack();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return TaskEditorPage(
                            // task: {
                            //   'id': '1',
                            //   'title': 'Prepare for project meeting',
                            //   'rich_description':
                            //       'Review project goals, prepare slides and talking points for team meeting',
                            //   'createdAt': DateTime(2023, 2, 20, 8, 0),
                            //   'beginAt': null,
                            //   'endAt': null,
                            //   'repeat': false,
                            //   'priority': 10,
                            //   'isCompleted': false,
                            //   'projectId': 'work',
                            //   'isVisible': true,
                            // },
                            );
                      },
                    ),
                  );
                },
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
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.settings),
              //   label: 'Settings',
              // ),
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
