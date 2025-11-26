import 'package:flutter/material.dart';
import 'package:lab_2/models/meal_model.dart';
import 'package:lab_2/models/recipe_model.dart';
import 'package:lab_2/services/APIService.dart';
import 'package:lab_2/widgets/recipe_image.dart';
import 'package:lab_2/widgets/recipe_ingredients.dart';
import 'package:lab_2/widgets/recipe_instructions.dart';
import 'package:lab_2/widgets/recipe_youtube_button.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool _isLoading = true;
  Recipe? recipe;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments;

    if (args is Recipe) {
      recipe = args;
      setState(() => _isLoading = false);
    }
    else if (args is Meal) {
      _loadRecipe(args.id);
    }
  }


  Future<void> _loadRecipe(int id) async {
    final data = await APIService().loadRecipeList(id);
    setState(() {
      recipe = data.first;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.red.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            RecipeImage(image: recipe!.img),
            const SizedBox(height: 20),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child:  Text(
                recipe!.name,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            RecipeIngredients(
              ingredients: recipe!.ingredients,
              measures: recipe!.measures,
            ),

            const SizedBox(height: 20),

            RecipeInstructions(instructions: recipe!.instructions),

            const SizedBox(height: 20),

            if (recipe!.link.isNotEmpty)
              RecipeYoutubeButton(url: recipe!.link),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
