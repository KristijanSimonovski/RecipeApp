import 'package:flutter/material.dart';
import 'package:lab_2/models/category_model.dart';
import 'package:lab_2/widgets/category_card.dart';

class CategoryGrid extends StatefulWidget {

  final List<Category> categoryList;

  const CategoryGrid({super.key, required this.categoryList});


  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 200/300
      ),
      itemCount: widget.categoryList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryCard(category: widget.categoryList[index]);
      },
    );
  }
}
