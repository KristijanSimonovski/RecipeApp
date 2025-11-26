import 'package:flutter/material.dart';
import 'package:lab_2/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.pushNamed(context, "/meals", arguments: category);
      // },

      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red.shade800, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Image.network(category.img, fit: BoxFit.cover),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),

              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Text(
                    category.description,
                    style: const TextStyle(fontSize: 14)
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: 0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/meals", arguments: category);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("View Meals"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
