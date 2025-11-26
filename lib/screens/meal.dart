import 'package:flutter/material.dart';
import 'package:lab_2/models/category_model.dart';
import 'package:lab_2/models/meal_model.dart';
import 'package:lab_2/services/APIService.dart';
import 'package:lab_2/widgets/meal_grid.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  List<Meal> _mealList = [];
  List<Meal> _filteredMeal = [];
  String _searchQuery = '';
  bool _isSearching = false;

  final _searchController = TextEditingController();
  final APIService _apiService = APIService();
  bool _isLoading = true;
  bool _didLoad = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_didLoad) {
      final category = ModalRoute.of(context)!.settings.arguments as Category;

      _loadMealList(category.name, 10);
      _didLoad = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final category =
    ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("${category.name} Meals"),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by meal name",
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red, width: 3),
                ),
              ),
              onChanged: _filterMeal,
            ),
          ),
          Expanded(
            child: _filteredMeal.isEmpty && _searchQuery.isNotEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off,
                      size: 64, color: Colors.red.shade100),
                  SizedBox(height: 16),
                  Text(
                      "Meal not found",
                      style: TextStyle(
                          fontSize: 18, color: Colors.red.shade100)
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _isSearching
                        ? null
                        : () async {
                      await _searchMealByName(_searchQuery);
                    },
                    child: _isSearching
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Search in API'),
                  ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 20),
              child: MealGrid(mealList: _filteredMeal),
            ),
          ),
        ],
      ),
    );
  }

  void _loadMealList(String categoryName, int n) async {
    final mealList = await _apiService.loadMealList(categoryName, n);

    setState(() {
      _mealList = mealList;
      _filteredMeal = mealList;
      _isLoading = false;
    });
  }

  void _filterMeal(String query) {
    setState(() {
      _searchQuery = query;
      _filteredMeal = query.isEmpty
          ? _mealList
          : _mealList
          .where((meal) =>
          meal.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  Future<void> _searchMealByName(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    final meal = await _apiService.searchMealByName(query);

    setState(() {
      _isSearching = false;
      if (meal != null) {
        _filteredMeal = [meal];
      } else {
        _filteredMeal= [];
      }
    });
  }

}
