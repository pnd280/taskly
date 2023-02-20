
import 'dart:convert';
import 'package:floor/floor.dart';


class Reminder {
  //set primary key for id
   String id;  
   String taskId;
   DateTime time;

  Reminder(this.id, this.taskId, this.time);
  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'taskId': taskId,
    'time': time,
  };}
  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      map['id'],
      map['taskId'],
      map['time'],
    );
  }
  
}
