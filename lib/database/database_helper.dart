import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String _dbName = 'business_app_database.db';
  final int _dbVersion = 1;
  Database? _database;

    static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Private named constructor
  DatabaseHelper._internal();

  // Factory constructor
  factory DatabaseHelper() {
    return _instance;
  }
  
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await getDatabase();
    return _database!;
  }

  Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);
    return await openDatabase(path, version: _dbVersion,
        onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE Users (
        id TEXT PRIMARY KEY,
        userName TEXT,
        password TEXT NOT NULL,
        email TEXT NOT NULL,
        isDeleted INTEGER DEFAULT 0
      )
    ''');

      await db.execute('''
        CREATE TABLE Expenses (
        id TEXT PRIMARY KEY,
        userID TEXT NOT NULL,
        amount REAL NOT NULL,
        createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        category TEXT NOT NULL,
        description TEXT,
        isDeleted INTEGER NOT NULL DEFAULT 0
        )
      ''');

    });
  }
}
