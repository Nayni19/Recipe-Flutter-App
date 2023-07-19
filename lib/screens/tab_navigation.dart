import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({super.key});

  @override
  State<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _currentPageIndex = 0;
  List<Meal> _favouriteMeals = [];

  void _toggleFavorite(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    print(meal);
    setState(() {
      if (isExisting) {
        _favouriteMeals.remove(meal);
      } else {
        _favouriteMeals.add(meal);
      }
    });
    Navigator.pop(context);
  }

  void _changeScreen(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CategoriesScreen(
      toggle: _toggleFavorite,
    );

    if (_currentPageIndex == 1) {
      content = MealsScreen(
        null,
        mealList: _favouriteMeals,
        toggle: _toggleFavorite,
      );
    }

    return Scaffold(
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 28, 44, 59),
        currentIndex: _currentPageIndex,
        onTap: _changeScreen,
        elevation: 3,
        selectedItemColor: Theme.of(context).colorScheme.background,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite')
        ],
      ),
    );
  }
}
