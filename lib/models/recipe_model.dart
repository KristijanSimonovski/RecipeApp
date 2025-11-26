class Recipe {
  int id;
  String img;
  String name;
  String instructions;
  List<String> ingredients;
  List<String> measures;
  String link;

  Recipe({
    required this.id,
    required this.img,
    required this.name,
    required this.instructions,
    required this.ingredients,
    required this.measures,
    required this.link,
  });

 factory Recipe.fromJson(Map<String, dynamic> data){
    List<String> ingredients = [];
    List<String> measures = [];

    for(int i=1; i<=20; i++) {
      String ingredient = data["strIngredient$i"];
      String measure = data["strMeasure$i"];

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredients.add(ingredient.trim());
        measures.add(measure?.trim() ?? "");
      }
    }
      return Recipe(
        id: int.parse(data['idMeal']),
        img: data['strMealThumb'],
        name: data['strMeal'],
        instructions: data['strInstructions'],
        ingredients: ingredients,
        measures: measures,
        link: data['strYoutube'] ?? "",
      );
    }
  }
