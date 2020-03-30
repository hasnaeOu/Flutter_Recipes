import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:json_annotation/json_annotation.dart';

class Tools {
  static Future<String> copyDataBase(String assetFullName) async {
    String path = '';
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

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

      // }else{
      //   throw new Exception("Database Already Exist!");
      // }
    } catch (e) {
      print("Erreur Copie : $e");
    }
    return path;
  }
}
