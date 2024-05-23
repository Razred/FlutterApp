
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:services/datamodels/dbform.dart';
import 'package:sqflite/sqflite.dart';



class DBProvider {
  static final DBProvider db = DBProvider();
  static Database ? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path,"TestDB.db");
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db){},onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Forms (username TEXT, question TEXT)");
    });
  }
  addForm(DBForm form) async {
    final db = await database;
    var raw = await db.rawInsert(
      "INSERT Into Forms (username, question) VALUES (?,?)", [form.username,form.question],
    );
    return raw;
  }
}