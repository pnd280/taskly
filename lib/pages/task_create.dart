import 'package:flutter/material.dart';
import 'package:taskly/miscs/colors.dart';
import 'package:taskly/miscs/styles.dart';
import 'package:taskly/pages/task_editor.dart';

class TaskCreatePage extends StatelessWidget {
  final toggleTaskCreatePageCallBack;

  const TaskCreatePage({super.key, required this.toggleTaskCreatePageCallBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: const BoxDecoration(
        boxShadow: [TasklyStyle.shadow],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(11),
          topRight: Radius.circular(11),
        ),
      ),
      child: Column(
        children: [
          OptionCard(
              icon: Icons.check,
              title: 'Add single task',
              description: 'Create a single task',
              callBack: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return TaskEditorPage();
                    },
                  ),
                );
                toggleTaskCreatePageCallBack(false);
              }),
          OptionCard(
            icon: Icons.done_all,
            title: 'Add project (task group)',
            description: 'Task group helps you to keep track of your work!',
          )
        ],
      ),
    );
  }

  Widget OptionCard(
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
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 15,
                            color: TasklyColor.blackText,
                          ),
                          child: Text(title),
                        ),
                        DefaultTextStyle(
                          style: const TextStyle(
                            color: TasklyColor.greyText,
                            fontSize: 12,
                          ),
                          child: Text(description),
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
