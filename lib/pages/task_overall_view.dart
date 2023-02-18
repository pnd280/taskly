import 'package:flutter/material.dart';

class TaskOverallViewPage extends StatefulWidget {
  const TaskOverallViewPage({super.key});

  @override
  State<TaskOverallViewPage> createState() => _TaskOverallViewPageState();
}

class _TaskOverallViewPageState extends State<TaskOverallViewPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('Task overall view')),
    );
  }
}