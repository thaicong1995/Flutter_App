import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class DB {
  static const String database = "todo_data00.db";
  static const int version = 1;
  static const String tableUser = "user_table";
  static const String tableTodo = "todo_table";
  static const String colId = "id";

  //sigleton class
  DB._contructor();
  static final DB instance = DB._contructor();
  static Database? _db;

  // Future<void> deleteDatabase() async {
  //   String path = join(await getDatabasesPath(), database);
  //   await databaseFactory.deleteDatabase(path);
  // }

  //Create database
  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), database);
    final Db = openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $tableUser (
            $colId INTEGER PRIMARY KEY AUTOINCREMENT,
            userName TEXT NOT NULL,
            password TEXT NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');
        print('User table created');
        db.execute(
          '''CREATE TABLE $tableTodo(
              $colId INTEGER PRIMARY KEY AUTOINCREMENT,
               title TEXT NOT NULL,
              description TEXT NOT NULL,
              deadline TEXT NOT NULL,
              isDone INTEGER NOT NULL,
              createdAt TEXT NOT NULL,
              userId INTEGER,
              FOREIGN KEY (userId) REFERENCES User($colId)
            )''',
        );
      },
      version: version,
    );
    return Db;
  }

  //Get Database
  Future<Database> get data async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  //Insert, update, delete, get
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await data;
    return await db.insert(table, row);
  }

  Future<User?> findByEmail(String username) async {
    final db = await data;
    List<Map<String, dynamic>> maps = await db.query(
      tableUser,
      where: 'userName = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await data;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return maps;
  }

  Future<void> delete(String table, int id) async {
    final db = await data;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}
