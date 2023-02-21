import 'dart:convert';

import 'dart:convert';

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
  
  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'title': title,
    'rich_description': rich_description,
    'createdAt': createdAt,
    'beginAt': beginAt,
    'endAt': endAt,
    'repeat': repeat,
    'priority': priority,
    'isCompleted': isCompleted,
    'projectId': projectId,
    'isVisible': isVisible,
  };}
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      map['id'],
      map['title'],
      map['rich_description'],
      map['createdAt'],
      map['beginAt'],
      map['endAt'],
      map['repeat'],
      map['priority'],
      map['isCompleted'],
      map['projectId'],
      map['isVisible'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Task(id: $id, title: $title, rich_description: $rich_description, createdAt: $createdAt, beginAt: $beginAt, endAt: $endAt, repeat: $repeat, priority: $priority, isCompleted: $isCompleted, projectId: $projectId, isVisible: $isVisible)';
  }
}

