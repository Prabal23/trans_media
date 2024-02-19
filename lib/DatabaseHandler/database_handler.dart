import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "trans_media.db";
  static final _databaseVersion = 3;

  static final table = 'product';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnLContent = 'content';
  static final columnImage = 'image';
  static final columnThumbnail = 'thumbnail';
  static final columnPrice = 'userId';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database?> get database1 async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  _initDatabase() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL, 
            $columnLContent TEXT NOT NULL, 
            $columnImage TEXT NOT NULL, 
            $columnThumbnail TEXT NOT NULL, 
            $columnPrice INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insertProduct(Map<String, dynamic> item) async {
    Database? db = await instance.database;
    return await db.insert(table, item);
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
