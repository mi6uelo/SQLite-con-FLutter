import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal();
  static DatabaseHelper get instance => _databaseHelper ??= DatabaseHelper._internal();

  Database? _db;
  Database get db => _db!;

  Future<void> init() async {
    _db = await openDatabase(
      'database.db',
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE computadoras (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            procesador TEXT NOT NULL,
            discoDuro TEXT NOT NULL,
            ram TEXT NOT NULL
          )
        ''');
      },
    );
  }
}
