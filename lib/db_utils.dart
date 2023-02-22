import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = 'app.db';
  static const _dbVersion = 1;

  static const _tableName = 'task';
  static const _columnId = 'id';
  static const _columnTitle = 'title';
  static const _columnRichDescription = 'rich_description';
  static const _columnCreatedAt = 'createdAt';
  static const _columnBeginAt = 'beginAt';
  static const _columnEndAt = 'endAt';
  static const _columnRepeat = 'repeat';
  static const _columnPriority = 'priority';
  static const _columnIsCompleted = 'isCompleted';
  static const _columnProjectId = 'projectId';
  static const _columnIsVisible = 'isVisible';

  DatabaseHelper._internal();

  static final DatabaseHelper databaseHelper = DatabaseHelper._internal();
  static DatabaseHelper get instance => databaseHelper;

  static Database ? _db;

  Future<Database ? > get database async {
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }


  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = '$dbPath/$_dbName';

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_columnId TEXT PRIMARY KEY,
        $_columnTitle TEXT NOT NULL,
        $_columnRichDescription TEXT NOT NULL,
        $_columnCreatedAt TEXT NOT NULL,
        $_columnBeginAt TEXT NOT NULL,
        $_columnEndAt TEXT,
        $_columnRepeat INTEGER NOT NULL,
        $_columnPriority INTEGER NOT NULL,
        $_columnIsCompleted INTEGER NOT NULL,
        $_columnProjectId TEXT,
        $_columnIsVisible INTEGER NOT NULL
      )
    ''');
  }
}