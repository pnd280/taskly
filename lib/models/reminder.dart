
import 'dart:convert';
import 'package:floor/floor.dart';


class Reminder {
  //set primary key for id
   String id;  
   String taskId;
   DateTime time;

  Reminder(this.id, this.taskId, this.time);
}
