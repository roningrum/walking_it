import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class DatabaseHandler{
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
     join(path, 'kesehatanDB'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE walking(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,langkah INTEGER NOT NULL, tgl TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }
}