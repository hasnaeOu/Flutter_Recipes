import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:meta/meta.dart';

class Recipe {
  static final db_id = "id";
  static final db_recipe_name = "recipe_name";
  static final db_image_preview = "image_preview";
  static final db_prepare_time = "prepare_time";
  static final db_cook_time = "cook_time";
  static final db_serves = "serves";
  static final db_summary = "summary";
  static final db_ingredients = "ingredients";
  static final db_directions = "directions";
  static final db_Is_Fav = "Is_Fav";

  int id;
  String name,
      img,
      preparetime,
      cooktime,
      serves,
      summary,
      ingredients,
      directions;
  bool favorited;

  Recipe(
      {@required this.id,
      @required this.name,
      @required this.img,
      @required this.preparetime,
      @required this.cooktime,
      @required this.serves,
      @required this.summary,
      @required this.ingredients,
      @required this.directions,
      this.favorited = false});

  Recipe.fromMap(Map<String, dynamic> map)
      : this(
          id: map[db_id],
          name: map[db_recipe_name],
          img: map[db_image_preview],
          preparetime: map[db_prepare_time],
          cooktime: map[db_cook_time],
          serves: map[db_serves],
          summary: map[db_summary],
          ingredients: map[db_ingredients],
          directions: map[db_directions],
          favorited: map[db_Is_Fav] == 0,
        );

  Recipe.fromJsonMap(Map<String, dynamic> map)
      : this(
          id: map[db_id],
          name: map[db_recipe_name],
          img: map[db_image_preview],
          preparetime: map[db_prepare_time],
          cooktime: map[db_cook_time],
          serves: map[db_serves],
          summary: map[db_summary],
          ingredients: map[db_ingredients],
          directions: map[db_directions],
          favorited: map[db_Is_Fav] == 0,
        );

  // Currently not used
  Map<String, dynamic> toMap() {
    return {
      db_id: id,
      db_recipe_name: name,
      db_image_preview: img,
      db_prepare_time: preparetime,
      db_cook_time: cooktime,
      db_serves: serves,
      db_summary: summary,
      db_ingredients: ingredients,
      db_directions: directions,
      db_Is_Fav: favorited ? 1 : 0,
    };
  }

  Map<String, dynamic> toJsonMap() => {
        db_id: id,
        db_recipe_name: name,
        db_image_preview: img,
        db_prepare_time: preparetime,
        db_cook_time: cooktime,
        db_serves: serves,
        db_summary: summary,
        db_ingredients: ingredients,
        db_directions: directions,
        db_Is_Fav: favorited ? 1 : 0,
      };

}
