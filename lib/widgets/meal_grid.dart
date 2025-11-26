import 'package:flutter/material.dart';
import 'package:lab_2/models/meal_model.dart';
import 'package:lab_2/widgets/meal_card.dart';

class MealGrid extends StatefulWidget {

  final List<Meal> mealList;

  const MealGrid({super.key, required this.mealList});


  @override
  State<MealGrid> createState() => _MealGridState();
}

class _MealGridState extends State<MealGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 200/300
      ),
      itemCount: widget.mealList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return MealCard(meal: widget.mealList[index]);
      },
    );
  }
}
