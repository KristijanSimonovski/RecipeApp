import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:lab_2/models/category_model.dart';
import 'package:lab_2/models/meal_model.dart';
import 'package:lab_2/models/recipe_model.dart';

class APIService{
  Future<List<Category>> loadCategoryList() async {
    final categoryResponse = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"),
    );

    if (categoryResponse.statusCode != 200) {
      throw Exception("Failed to load categories");
    }

    final Map<String, dynamic> data = jsonDecode(categoryResponse.body);

    final List<dynamic> list = data["categories"];

    return list.map((item) => Category.fromJson(item)).toList();
  }


  Future<List<Meal>> loadMealList(String categoryName, int n) async {
    final mealResponse = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName"),
    );

    if (mealResponse.statusCode != 200) {
      throw Exception("Failed to load meals");
    }

    final Map<String, dynamic> data = jsonDecode(mealResponse.body);
    final List<dynamic> list = data["meals"];

    List<Meal> result = [];

    for (int i = 0; i < n && i < list.length; i++) {
      result.add(Meal.fromJson(list[i]));
    }
    return result;
  }

  Future<Meal?> searchMealByName(String query) async {
    try {
      final response = await http.get(
        Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=${query.toLowerCase()}"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Meal.fromJson(data["meals"][0]);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Recipe>> loadRecipeList(int id) async {
    final recipeResponse = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id"),
    );

    if (recipeResponse.statusCode != 200) {
      throw Exception("Failed to load categories");
    }

    final Map<String, dynamic> data = jsonDecode(recipeResponse.body);

    final List<dynamic> list = data["meals"];

    return list.map((item) => Recipe.fromJson(item)).toList();
  }


  Future<Recipe> getRandomRecipe() async {
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load random recipe");
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    return Recipe.fromJson(data["meals"][0]);
  }





}