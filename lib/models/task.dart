import 'package:uuid/uuid.dart';

class TaskModel {
  String id;
  String title;
  String richDescription;
  DateTime createdAt;
  DateTime beginAt;
  dynamic endAt;
  bool repeat;
  int priority;
  bool isCompleted;
  String? projectId;
  bool isVisible;

  TaskModel({
    required this.id,
    required this.title,
    required this.richDescription,
    required this.createdAt,
    required this.beginAt,
    required this.endAt,
    this.repeat = false,
    this.priority = 4,
    this.isCompleted = false,
    this.projectId,
    this.isVisible = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'title': title,
      'rich_description': richDescription,
      'createdAt': createdAt.toIso8601String(),
      'beginAt': beginAt.toIso8601String(),
      'endAt': endAt != null ? endAt.toIso8601String() : null,
      'repeat': repeat ? 1 : 0,
      'priority': priority,
      'isCompleted': isCompleted ? 1 : 0,
      'projectId': projectId,
      'isVisible': isVisible ? 1 : 0,
    };
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: Uuid.unparse(Uuid.parse(map['id'])),
      title: map['title'],
      richDescription: map['rich_description'],
      createdAt: DateTime.parse(map['createdAt']),
      beginAt: DateTime.parse(map['beginAt']),
      endAt: DateTime.parse(map['endAt']),
      repeat: map['repeat'] == 1 ? true : false,
      priority: map['priority'],
      isCompleted: map['isCompleted'] == 1 ? true : false,
      projectId: map['projectId'],
      isVisible: map['isVisible'] == 1 ? true : false,
    );
  }
}
