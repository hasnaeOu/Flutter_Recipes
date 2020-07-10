import 'package:meta/meta.dart';

class Recipe {
  static final dbTable = "tbl_recipes";
  static final dbId = "id";
  static final dbRecipeName = "recipe_name";
  static final dbImagePreview = "image_preview";
  static final dbPrepareTime = "prepare_time";
  static final dbCookTime = "cook_time";
  static final dbServes = "serves";
  static final dbSummary = "summary";
  static final dbIngredients = "ingredients";
  static final dbDirections = "directions";
  static final dbIsFav = "Is_Fav";

  int id;
  String name,
      img,
      prepareTime,
      cookTime,
      serves,
      summary,
      ingredients,
      directions;
  bool favorited;

  Recipe(
      {@required this.id,
      @required this.name,
      @required this.img,
        @required this.prepareTime,
        @required this.cookTime,
      @required this.serves,
      @required this.summary,
      @required this.ingredients,
      @required this.directions,
      this.favorited = false});

  Recipe.fromMap(Map<String, dynamic> map)
      : this(
    id: map[dbId],
    name: map[dbRecipeName],
    img: map[dbImagePreview],
    prepareTime: map[dbPrepareTime],
    cookTime: map[dbCookTime],
    serves: map[dbServes],
    summary: map[dbSummary],
    ingredients: map[dbIngredients],
    directions: map[dbDirections],
    favorited: map[dbIsFav] == 0,
        );


  Map<String, dynamic> toMap() {
    return {
      dbId: id,
      dbRecipeName: name,
      dbImagePreview: img,
      dbPrepareTime: prepareTime,
      dbCookTime: cookTime,
      dbServes: serves,
      dbSummary: summary,
      dbIngredients: ingredients,
      dbDirections: directions,
      dbIsFav: favorited ? 1 : 0,
    };
  }

}