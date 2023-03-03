import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:walking_it/sqflite/user.dart';
import 'package:walking_it/sqflite/walking.dart';

class DatabaseHandler{
  static Future<Database> initializeDB() async{
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
  //user
  static Future<int> saveUserData(User user) async{
    final Database db = await initializeDB();
    final id = await db.insert('user', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // untuk Login
  static Future<User?> getLogin(String email, String password) async{
    var dbClient = await initializeDB();
    var res = await dbClient.rawQuery("SELECT * FROM user WHERE email = $email and password = $password");
    if(res.length > 0){
      return User.fromMap(res.first);
    }
    return null;
  }

  static Future<int> insertWalkingData(Walking walking) async{
    final Database db = await initializeDB();
    final id = await db.insert('walking', walking.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getWalking() async{
    final db = await initializeDB();
    return db.query('walking', orderBy: "id");
  }

  static Future<int> updateItemTable(int id, String name, int langkah, String date) async{
    final db = await initializeDB();
    final data = {
      'name' : name,
      'langkah': langkah,
      'tgl': DateTime.now().toString()
    };
    final result = await db.update('walking', data, where: "id = ?", whereArgs: [id]);
    return result;

  }
}