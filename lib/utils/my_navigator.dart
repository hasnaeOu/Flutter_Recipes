import 'package:flutter/material.dart';
import 'package:recipe/models/recipe_medel.dart';

class MyNavigator{
  static void goHome(BuildContext context){
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goFavorites(BuildContext context){
    Navigator.pushNamed(context, '/favorites');
  }

  static void goSearch(BuildContext context){
    Navigator.pushNamed(context, '/search');
  }

  static void goRecipeDetails(BuildContext context, Recipe recipe){
    Navigator.pushNamed(context, '/recipe_details',arguments: {"recipe": recipe});
  }

  static void goAbout(BuildContext context){
    Navigator.pushNamed(context, '/about');
  }

  static void goPrivacy(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }
}