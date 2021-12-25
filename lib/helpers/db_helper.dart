import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

//SQFLITE
class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    //einmal die Datenbank erstellen in einer Variablen
    return sql.openDatabase(path.join(dbPath, 'diaetplaner.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE diaet_log(id TEXT PRIMARY KEY, title TEXT, kcal TEXT, carbohydrates TEXT, startWeight Text, newWeight TEXT, maxKcal Text, difKcal Text)');
    }, version: 1);
  }

//Da der Eintrag dauern kann bis es in die Daten gespeichert weerden = Future + async
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  //Delete data from table
  static Future<void> delete(String id) async {
    final db = await DBHelper.database();
    var res = await db.delete('diaet_log', where: "id = ?", whereArgs: [id]);
    return res;
  }

  //Update Data
  static Future<void> updateData(
      String title, String description, String pieces, String id) async {
    final db = await DBHelper.database();
    int res = await db.rawUpdate(
        'UPDATE diaet_log SET title = ?, pieces = ?  WHERE id = ?',
        [title, description, pieces, id]);
    return res;
  }

  //Methode um Einträge zu holen
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  Future<List> getAllRecords(String table) async {
    var dbCliebt = await DBHelper.database();
    var result = await dbCliebt.rawQuery('SELECT * FROM "diaet_log"');

    return result.toList();
  }
}
