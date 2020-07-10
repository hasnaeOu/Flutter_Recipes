import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe/models/recipe_medel.dart';
import 'package:sqflite/sqflite.dart';

class TemplateDatabaseProvider {
  TemplateDatabaseProvider();

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
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'myData', 'db_recipes.db');
    return await openDatabase(path);
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
    return jsons.map((json) => Recipe.fromMap(json)).toList();
  }

  Future<List<Recipe>> getFavRecipes() async {
    final db = await getdatabase();
    //print('from getAllRecipes : path = ${this.path}');
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Map> jsons = await db
        .rawQuery('SELECT * FROM tbl_recipes WHERE ${Recipe.dbIsFav} = ?', [0]);
    //print('${jsons.length} rows retrieved from db!');
    return jsons.map((json) => Recipe.fromMap(json)).toList();
  }

  Future<List<Recipe>> searchRecipes(String keyword) async {
    final db = await getdatabase();
    //print('from getAllRecipes : path = ${this.path}');
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Map> jsons = await db.rawQuery(
        'SELECT * FROM tbl_recipes WHERE ${Recipe.dbRecipeName} LIKE "%$keyword%" OR ${Recipe.dbIngredients} LIKE "%$keyword%" OR ${Recipe.dbDirections} LIKE "%$keyword%"');
    //print('${jsons.length} rows retrieved from db!');
    return jsons.map((json) => Recipe.fromMap(json)).toList();
  }

  Future<List<Recipe>> searchFavRecipes(String keyword) async {
    final db = await getdatabase();
    //print('from getAllRecipes : path = ${this.path}');
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Map> jsons = await db.rawQuery(
        'SELECT * FROM tbl_recipes WHERE ${Recipe.dbRecipeName} LIKE "%$keyword%" AND ${Recipe.dbIsFav} = "0"');
    //print('${jsons.length} rows retrieved from db!');
    return jsons.map((json) => Recipe.fromMap(json)).toList();
  }

  Future<int> updateFav(int myid, bool operation) async {
    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await getdatabase();

    // row to update
    Map<String, dynamic> row = {
      Recipe.dbIsFav: operation,
    };

    // We'll update the first row just as an example
    int id = myid;

    // do the update and get the number of affected rows
    int updateCount = await db.update(Recipe.dbTable, row,
        where: '${Recipe.dbId} = ?', whereArgs: [id]);

    // show the results: print all rows in the db
    print(await db.query(Recipe.dbTable));
    return updateCount;
  }

  Future<int> switchFav(int id, bool b) async {
    Database db = await getdatabase();
    int updateCount = await db.rawUpdate('''
    UPDATE ${Recipe.dbTable} 
    SET ${Recipe.dbIsFav} = ?
    WHERE ${Recipe.dbId} = ?
    ''', [b ? 1 : 0, id]);

    print('b =====================> $b');
    print('id =====================> $id');
    print(
        '=================RESULT rawUpdate====================> $updateCount');

    return updateCount;
  }

  /* static TemplateDatabaseProvider get(String mypath) {

    return db;
  } */

  Future<Recipe> getArticl(String id) async {
    var db = await getdatabase();
    var result = await db
        .rawQuery('SELECT * FROM tbl_recipes WHERE ${Recipe.dbId} = "$id"');
    if (result.length == 0) return null;
    return new Recipe.fromMap(result[0]);
  }
}
