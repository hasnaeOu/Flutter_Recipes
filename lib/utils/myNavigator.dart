import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/intro",);
  }

  static void goToCategorie(BuildContext context) {
    Navigator.pushNamed(context, "/categorie",);
  }
}