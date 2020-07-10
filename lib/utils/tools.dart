import 'package:recipe/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

<<<<<<< HEAD
class Tools{
  static launchURLRate(String appName) async {
    var url =
        'https://play.google.com/store/apps/details?id=' + appName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchURLMore() async {
    var url = 'https://play.google.com/store/apps/developer?id=' +
        Strings.store.split(' ').join(('+'));
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<String> copyDataBase() async {
=======
class Tools {
  static Future<String> copyDataBase(String assetFullName) async {
>>>>>>> fcba3f1cdd7b12232fd081efbabf13222cac9e39
    String path = '';
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

<<<<<<< HEAD
      String assetFullName = 'assets/database/db_recipes.db';
=======
>>>>>>> fcba3f1cdd7b12232fd081efbabf13222cac9e39
      /* final Map<String, dynamic> manifestMap = jsonDecode(await manifestContent);

      final databasesPaths = manifestMap.keys
      .where((String key) => key.contains('databases/'))
      .where((String key) => key.contains('.db'))
      .toList();
      
      print("Databases :::::::::::::::::::::::::: $databasesPaths"); */

      Directory(documentsDirectory.path + '/myData').createSync();

      path = join(documentsDirectory.path, 'myData',assetFullName.split('/').last);
      // Only copy if the database doesn't exist
      //if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(assetFullName);
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
      print("==============================> Item Copied : $path");

<<<<<<< HEAD
     /*  }else{
        print("==============================> Database Already Exist!");
      } */
=======
      // }else{
      //   throw new Exception("Database Already Exist!");
      // }
>>>>>>> fcba3f1cdd7b12232fd081efbabf13222cac9e39
    } catch (e) {
      print("Erreur Copie : $e");
    }
    return path;
  }
}
