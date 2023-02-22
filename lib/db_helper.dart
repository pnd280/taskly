import 'package:taskly/db_utils.dart';

import './models/task.dart';

class TaskDatabaseHelper {
  static String tableName = 'task';

  static Future<void> insertTask(TaskModel task) async {
    final db = await DatabaseHelper.instance.database;
    await db!.insert(
      tableName,
      task.toMap(),
    );
  }

  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await DatabaseHelper.instance.database;
    return await db!.query(tableName);
  }

  static Future<void> getTaskById(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> updateTask(TaskModel task) async {
    final db = await DatabaseHelper.instance.database;
    await db!.update(
      tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<void> deleteTask(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //delete all tasks
  static Future<void> deleteAllTasks() async {
    final db = await DatabaseHelper.instance.database;
    await db!.delete(tableName);
  }
}