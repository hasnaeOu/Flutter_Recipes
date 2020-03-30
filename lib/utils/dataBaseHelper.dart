import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:recipes/models/recipeModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TemplateDatabaseProvider {

  final String path;
  TemplateDatabaseProvider(this.path);

  //final TemplateDatabaseProvider db = TemplateDatabaseProvider('');

  Database _database;

/* Future<Database> _getDb() async {
  if (_database != null)
  return _database;
  // if _database is null we instantiate it
  _database = await initDB();
  return _database;
} */

  Future<Database> getdatabase() async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String databasePath = this.path;
    return await openDatabase(databasePath);
  }

// Future<List<String>> getAllDatabasesNames() async{
//   final db = await database;
//   // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
//   List<Map> jsons = await db.rawQuery('SELECT * FROM Articl');
//   print('${jsons.length} rows retrieved from db!');
//   return jsons.map((json) => Articl.fromJsonMap(json)).toList();
// }

  Future<List<Recipe>> getAllRecipes() async {
    final db = await getdatabase();
    //print('from getAllRecipes : path = ${this.path}');
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Map> jsons = await db.rawQuery('SELECT * FROM tbl_recipes');
    //print('${jsons.length} rows retrieved from db!');
    return jsons.map((json) => Recipe.fromJsonMap(json)).toList();
  }

  /* static TemplateDatabaseProvider get(String mypath) {

    return db;
  } */

//   Future<Articl> getArticl(String id) async{
//   var db = await database;
//   var result = await db.rawQuery('SELECT * FROM Articl WHERE ${Articl.db_id} = "$id"');
//   if(result.length == 0)return null;
//   return new Articl.fromMap(result[0]);
//   }
}
