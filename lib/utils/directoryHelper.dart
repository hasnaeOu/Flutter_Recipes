import 'dart:async';

import 'dart:io';
import 'package:path/path.dart';

class DirectoryHelper {

  DirectoryHelper(String path);

  static List getContents(String path) {
    Directory directory = Directory(path);
    return directory.listSync();
  }

  static List getDbList(String path) {
    Directory directory = Directory(path);
    return directory.listSync();
  }

  static List<String> getList(String path) {
    List<String> L = new List<String>();
    Directory sdCardDirectory = Directory(join(path,'myData'));

    List contents = sdCardDirectory.listSync();
    for (var fileOrDir in contents) {
      if (fileOrDir is File && extension(fileOrDir.path) == '.db') {
        L.add('${fileOrDir.path}');
      }
    }
    return L;
  }

  

}
