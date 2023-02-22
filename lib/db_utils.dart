import 'package:sqflite/sqflite.dart';

class Task {
  String id;
  String title;
  String richDescription;
  DateTime createdAt;
  DateTime beginAt;
  DateTime endAt;
  bool repeat;
  int priority;
  bool isCompleted;
  String projectId;
  bool isVisible;

  Task({
    required this.id,
    required this.title,
    required this.richDescription,
    required this.createdAt,
    required this.beginAt,
    required this.endAt,
    required this.repeat,
    required this.priority,
    required this.isCompleted,
    required this.projectId,
    required this.isVisible,
  });

  static final String tableName = "Task";

  static final String columnId = "id";
  static final String columnTitle = "title";
  static final String columnRichDescription = "rich_description";
  static final String columnCreatedAt = "createdAt";
  static final String columnBeginAt = "beginAt";
  static final String columnEndAt = "endAt";
  static final String columnRepeat = "repeat";
  static final String columnPriority = "priority";
  static final String columnIsCompleted = "isCompleted";
  static final String columnProjectId = "projectId";
  static final String columnIsVisible = "isVisible";

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnTitle: title,
      columnRichDescription: richDescription,
      columnCreatedAt: createdAt.toIso8601String(),
      columnBeginAt: beginAt.toIso8601String(),
      columnEndAt: endAt.toIso8601String(),
      columnRepeat: repeat ? 1 : 0,
      columnPriority: priority,
      columnIsCompleted: isCompleted ? 1 : 0,
      columnProjectId: projectId,
      columnIsVisible: isVisible ? 1 : 0,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map[columnId],
      title: map[columnTitle],
      richDescription: map[columnRichDescription],
      createdAt: DateTime.parse(map[columnCreatedAt]),
      beginAt: DateTime.parse(map[columnBeginAt]),
      endAt: DateTime.parse(map[columnEndAt]),
      repeat: map[columnRepeat] == 1,
      priority: map[columnPriority],
      isCompleted: map[columnIsCompleted] == 1,
      projectId: map[columnProjectId],
      isVisible: map[columnIsVisible] == 1,
    );
  }

  static Future<List<Task>> getAllTasks(Database db) async {
    List<Map<String, dynamic>> maps = await db.query(tableName);
    List<Task> tasks = [];
    for (Map<String, dynamic> map in maps) {
      tasks.add(fromMap(map));
    }
    return tasks;
  }

  static dynamic getTaskById(Database db, String id) async {
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: "$columnId = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return fromMap(maps.first);
    }
    return null;
  }

  Future<int> insert(Database db) async {
    return await db.insert(tableName, toMap());
  }

  Future<int> update(Database db) async {
    return await db.update(
      tableName,
      toMap(),
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future<int> delete(Database db) async {
    return await db.delete(
      tableName,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }
}
