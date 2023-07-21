import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/provider/favourites_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabNavigation extends ConsumerStatefulWidget {
  const TabNavigation({super.key});

  @override
  ConsumerState<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends ConsumerState<TabNavigation> {
  int _currentPageIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> availableMeal = ref.watch(filterMealsProvider);

    Widget content = CategoriesScreen(
      filteredMeal: availableMeal,
    );

    if (_currentPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      content = MealsScreen(
        null,
        mealList: favoriteMeals,
      );
    }

    if (_currentPageIndex == 2) {
      content = const FilterScreen();
    }

    return Scaffold(
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 28, 44, 59),
        currentIndex: _currentPageIndex,
        onTap: _changeScreen,
        elevation: 3,
        selectedItemColor: Theme.of(context).colorScheme.background,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Category',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.filter), label: 'Filter')
        ],
      ),
    );
  }
}
