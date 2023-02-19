CREATE TABLE `Reminder` (
  `id` text PRIMARY KEY,
  `taskId` text,
  `time` datetime
);

import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';

class Reminder {
  //set primary key for id
  @primaryKey
  final String id = Uuid().v4();
  //set foreign key for taskId
  @ForeignKey(
    entity: Task,
    parentColumns: ['id'],
    childColumns: ['taskId'],
  )
  final String taskId;
  final DateTime time;
  Reminder(this.taskId, this.time);
}