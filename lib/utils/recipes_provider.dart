import 'package:flutter/material.dart';
import 'package:recipe/models/recipe_medel.dart';
import 'package:recipe/utils/database_helper.dart';

class RecipesProvider with ChangeNotifier {
  //                          <--- MyModel
  List<Recipe> recipes = new List<Recipe>();
  List<Recipe> favRecipes = new List<Recipe>();

  void getRecipesList() {
    TemplateDatabaseProvider provider = new TemplateDatabaseProvider();
    provider.getAllRecipes().then((onValue) {
      this.recipes = onValue;
      notifyListeners();
    });
  }

  void getFavRecipesList() {
    TemplateDatabaseProvider provider = new TemplateDatabaseProvider();
    provider.getFavRecipes().then((onValue) {
      this.favRecipes = onValue;
      notifyListeners();
    });
  }

  void updateFav(int myId, bool operation) {
    TemplateDatabaseProvider provider = new TemplateDatabaseProvider();
    provider.switchFav(myId, operation);
    notifyListeners();
  }

  void updateListRecipes() {
    getRecipesList();
    notifyListeners();
  }
}
