import 'dart:convert';
import 'package:floor/floor.dart';


class Task { 
  //set primary key for id
  final String id;  
  final String title;  
  final int rich_description;
  final DateTime createdAt;
  final DateTime beginAt;
  final DateTime endAt;
  final bool repeat;
  final int priority;
  final bool isCompleted; 
  final String projectId;
  final bool isVisible;
  Task(this.id, this.title, this.rich_description, this.createdAt, this.beginAt, this.endAt, this.repeat, this.priority, this.isCompleted, this.projectId, this.isVisible); 
}
