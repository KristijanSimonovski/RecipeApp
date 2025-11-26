import 'package:flutter/material.dart';
import 'package:lab_2/models/category_model.dart';
import 'package:lab_2/models/recipe_model.dart';
import 'package:lab_2/services/APIService.dart';
import 'package:lab_2/widgets/category_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Category> _categoryList = [];
  List<Category> _filteredCategory = [];
  String _searchQuery = '';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final APIService _apiService = APIService();
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadCategoryList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: _openRandomRecipe,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Give me random recipe",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )

        ],


      ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search by category name",
                        prefixIcon: const Icon(Icons.search),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),
                      ),

                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                        _filterCategory(value);
                      },
                    ),
                  ),
                  Text(
                      "Explore the following categories:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),),
                  Expanded(
                      child: _filteredCategory.isEmpty && _searchQuery.isNotEmpty
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search_off, size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text(
                                "Category not found",
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      )
                        : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: CategoryGrid(categoryList: _filteredCategory),
                      )
                  )
                ],
        )
    );
  }

  void _loadCategoryList() async {
    final categoryList = await _apiService.loadCategoryList();

    setState(() {
      _categoryList = categoryList;
      _filteredCategory = categoryList;
      _isLoading = false;
    });
  }


  void _filterCategory(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategory = _categoryList;
      } else {
        _filteredCategory = _categoryList
            .where((meal) =>
            meal.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }


  Future<void> _openRandomRecipe() async {
    try {
      final Recipe randomRecipe = await _apiService.getRandomRecipe();

      Navigator.pushNamed(
        context,
        "/recipe",
        arguments: randomRecipe,
      );
    } catch (e) {
      print("Random recipe error: $e");
    }
  }










}




