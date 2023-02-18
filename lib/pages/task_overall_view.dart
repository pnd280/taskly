import 'package:flutter/material.dart';

class TaskOverallViewPage extends StatefulWidget {
  const TaskOverallViewPage({super.key});

  @override
  State<TaskOverallViewPage> createState() => _TaskOverallViewPageState();
}

class _TaskOverallViewPageState extends State<TaskOverallViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: Placeholder(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Placeholder(),
            ),
          ),
        ],
      ),
    );
  }
}
