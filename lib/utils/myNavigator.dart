import 'package:flutter/material.dart';
import 'package:recipes/screens/categorieScreen.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/intro",);
  }

  static void goToCategorie(BuildContext context, String dbName, String dbPath) {
    Navigator.pushNamed(context, "/categorie",arguments: CategorieScreen(title: dbName,path: dbPath));
  }
}