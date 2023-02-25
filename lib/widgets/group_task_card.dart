import 'package:flutter/material.dart';

class GroupTaskCard extends StatefulWidget {
  const GroupTaskCard({super.key});

  @override
  State<GroupTaskCard> createState() => GroupTaskCardState();
}

class GroupTaskCardState extends State<GroupTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Group Task Card'),),
    );
  }
}