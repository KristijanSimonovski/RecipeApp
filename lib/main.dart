import 'package:flutter/material.dart';
import 'package:lab_2/screens/home.dart';
import 'package:lab_2/screens/meal.dart';
import 'package:lab_2/screens/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover Meals App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      initialRoute: "/",
        routes: {
          "/": (context) => const MyHomePage(title: 'Lab2 - 221244'),
          "/meals": (context) => const MealPage(),
          "/recipe": (context) => const RecipePage(),
        }
      );
    }
  }
