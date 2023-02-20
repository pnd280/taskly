import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'General',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [TasklyStyle.shadow],
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Column(
                            children: [
                              SettingCard(
                                icon: Icons.calendar_today_rounded,
                                title: 'Calendar',
                                description: 'Manage calendar views',
                              ),
                              const Divider(color: TasklyColor.greyText),
                              SettingCard(
                                icon: CupertinoIcons.check_mark_circled_solid,
                                title: 'Tasks',
                                description: 'Manage task appearances',
                                color: Colors.orange.shade400,
                              ),
                              const Divider(color: TasklyColor.greyText),
                              SettingCard(
                                icon: Icons.home_rounded,
                                title: 'Icon',
                                description: 'Custom icon packs',
                                color: Colors.blue.shade700,
                              ),
                              const Divider(color: TasklyColor.greyText),
                              SettingCard(
                                icon: Icons.dark_mode_rounded,
                                title: 'Theme',
                                description: 'Switch to Dark Mode',
                                color: Colors.blueGrey.shade700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'System',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [TasklyStyle.shadow],
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Column(
                            children: [
                              SettingCard(
                                icon: Icons.notifications_active,
                                title: 'Notifications',
                                description: 'Allowed',
                                color: Colors.grey.shade700,
                              ),
                              const Divider(color: TasklyColor.greyText),
                              SettingCard(
                                icon: CupertinoIcons.question_circle_fill,
                                title: 'FAQ',
                                description: 'Need help?',
                                color: Colors.grey.shade700,
                              ),
                              const Divider(color: TasklyColor.greyText),
                              SettingCard(
                                icon: CupertinoIcons.clock_solid,
                                title: 'Date & Time',
                                description: 'Time format options',
                                color: Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SettingCard(
      {required IconData icon,
      required String title,
      required String description,
      Color? color,
      Function? callBack}) {
    return GestureDetector(
      onTap: () {
        callBack == null ? null : callBack();
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color ?? TasklyColor.VeriPeri,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          description,
                          style: const TextStyle(
                              color: TasklyColor.greyText, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
            )
          ],
        ),
      ),
    );
  }
}
