import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_helper;

class DatabaseHelper {
  static final _databaseName = "db.db";
  static final _databaseVersion = 1;
  static final table = 'user_table';

  static final columnId = '_id';
  static final columnName = 'username';
  static final columnPassword = 'password';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path_helper.join(databasesPath, _databaseName);
    return await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
      ''');
  }

  Future<void> insertUser(String username, String password) async {
    try {
      Database db = await instance.database;
      await db.insert(table, {
        columnName: username,
        columnPassword: password,
      });
      print('User inserted successfully');
    } catch (e) {
      print('Error inserting user: $e');
    }
  }
}
