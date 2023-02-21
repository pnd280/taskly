import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
//import floor


import 'package:taskly/models/project.dart';
import 'package:taskly/models/reminder.dart';
import 'package:taskly/models/tag.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/models/tagged_tag.dart';
import 'package:taskly/models/repeat_task.dart';
class DatabaseHelper {
  static final _databaseName = "Taskly.db";
  static final _databaseVersion = 1;
  
  //task table
  static final tableTask="task";
  static final columnTaskId = 'id';
  static final columnTaskTitle = 'title';
  static final columnTaskRichDescription = 'rich_description';
  static final columnTaskCreatedAt = 'createdAt';
  static final columnTaskBeginAt = 'beginAt';
  static final columnTaskEndAt = 'endAt';
  static final columnTaskIsVisible = 'isVisible';
  static final columnTaskIsCompleted = 'isCompleted';
  static final columnTaskRepeat = 'repeat';
  static final columnTaskPriority = 'priority';
  static final columnTaskProjectId = 'projectId';

  //project table
  static final tableProject="project";
  static final columnProjectId = 'id';
  static final columnProjectTitle = 'title';
  static final columnProjectDescription = 'description';
  static final columnProjectCreatedAt = 'createdAt';
  static final columnProjectIsVisible = 'isVisible';

  //tag table
  static final tableTag="tag";
  static final columnTagId = 'id';
  static final columnTagTitle = 'title';
  static final columnTagColor = 'color';
  static final columnTagIsVisible = 'isVisible';

  //reminder table
  static final tableReminder="reminder";
  static final columnReminderId = 'id';
  static final columnReminderTaskId = 'taskId';

  //tagged tag table
  static final tableTaggedTag="tagged_tag";
  
  static final columnTaggedTagTaskId = 'taskId';
  static final columnTaggedTagTagId = 'tagId';

  //repeat task table
  static final tableRepeatTask="repeat_task";
  static final columnRepeatTaskId = 'id';
  static final columnweekDay = 'weekDay';
  static final columnNextDueDate = 'nextDueDate';
  static final columnInterval = 'interval';
 
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }
  Future<void> _onCreate(Database db, int version) async {

    //create Task table
    await db.execute('''
      CREATE TABLE $tableTask (
        $columnTaskId TEXT PRIMARY KEY,
        $columnTaskTitle TEXT ,
        $columnTaskRichDescription TEXT ,
        $columnTaskCreatedAt DATETIME ,
        $columnTaskBeginAt DATETIME ,
        $columnTaskEndAt DATETIME ,
        $columnTaskRepeat BOOLEAN ,
        $columnTaskPriority INTEGER ,
        $columnTaskIsCompleted BOOLEAN ,
        $columnTaskProjectId TEXT ,
        $columnTaskIsVisible BOOLEAN 
        FOREIGN KEY ($columnTaskProjectId) REFERENCES $tableProject($columnProjectId)
      )
    ''');
    //table project
    await db.execute('''
      CREATE TABLE $tableProject (
        $columnProjectId TEXT PRIMARY KEY,
        $columnProjectTitle TEXT ,
        $columnProjectDescription TEXT ,
        $columnProjectCreatedAt DATETIME ,
        $columnProjectIsVisible BOOLEAN DEFAULT TRUE
      )
    ''');
    //table tag
    await db.execute('''
      CREATE TABLE $tableTag (
        $columnTagId TEXT PRIMARY KEY,
        $columnTagTitle TEXT ,
        $columnTagColor TEXT COMMENT 'Hexadecimal format' ,
        $columnTagIsVisible BOOLEAN DEFAULT TRUE
      )
    ''');
    //table reminder
    await db.execute('''
      CREATE TABLE $tableReminder (
        $columnReminderId TEXT PRIMARY KEY,
        $columnReminderTaskId TEXT ,
        FOREIGN KEY ($columnReminderTaskId) REFERENCES $tableTask($columnTaskId)
      )
    ''');
    //table tagged tag
    await db.execute('''
      CREATE TABLE $tableTaggedTag (
        $columnTaggedTagTaskId TEXT ,
        $columnTaggedTagTagId TEXT ,
        FOREIGN KEY ($columnTaggedTagTaskId) REFERENCES $tableTask($columnTaskId),
        FOREIGN KEY ($columnTaggedTagTagId) REFERENCES $tableTag($columnTagId)
      )
    ''');
    //table repeat task
    await db.execute('''
      CREATE TABLE $tableRepeatTask (
        $columnRepeatTaskId TEXT PRIMARY KEY,
        $columnweekDay INTEGER ,
        $columnNextDueDate DATETIME ,
        $columnInterval INTEGER ,
        FOREIGN KEY ($columnRepeatTaskId) REFERENCES $tableTask($columnTaskId)
      )
    ''');
  }
  Future<int> insertTask(Task task) async {
    Database db = await instance.database;
    return await db.insert(tableTask, task.toMap());
  }
  //get all tasks 
  Future<List<Task>> queryAllTasks() async {
    Database db = await instance.database;
    var res = await db.query(tableTask);
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  //update task
  Future<int> updateTask(Task task) async {
    Database db = await instance.database;
    return await db.update(tableTask, task.toMap(),
        where: '$columnTaskId = ?', whereArgs: [task.id]);
  }
  //delete task
  Future<int> deleteTask(String id) async {
    Database db = await instance.database;
    return await db.delete(tableTask, where: '$columnTaskId = ?', whereArgs: [id]);
  }
  //filter task by project
  Future<List<Task>> filterTaskByProject(String projectId) async {
    Database db = await instance.database;
    var res = await db.query(tableTask,where: '$columnTaskProjectId = ?', whereArgs: [projectId]);
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  //filter task by tag
  Future<List<Task>> filterTaskByTag(String tagId) async {
    Database db = await instance.database;
    var res = await db.query(tableTaggedTag,where: '$columnTaggedTagTagId = ?', whereArgs: [tagId]);
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  Future<int> insertProject(Project project) async {
    Database db = await instance.database;
    return await db.insert(tableProject, project.toMap());
  }
  
  Future<int> insertTag(Tag tag) async {
    Database db = await instance.database;
    return await db.insert(tableTag, tag.toMap());
  }
  Future<int> insertReminder(Reminder reminder) async {
    Database db = await instance.database;
    return await db.insert(tableReminder, reminder.toMap());
  }
  Future<int> insertTaggedTag(Tagged taggedTag) async {
    Database db = await instance.database;
    return await db.insert(tableTaggedTag, taggedTag.toMap());
  }
  Future<int> insertRepeatTask(Repeat_Task repeatTask) async {
    Database db = await instance.database;
    return await db.insert(tableRepeatTask, repeatTask.toMap());
  }
  //get all tasks
}
// write main function to run DB init
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  //create database
  
}
