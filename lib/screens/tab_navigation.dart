import 'package:flutter/material.dart';
import 'package:meals_app/data/meals_data.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({super.key});

  @override
  State<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _currentPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false
  };

  List<Meal> _availableMeal = [];

  void filterMeals() {
    _availableMeal = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  }

  void onSubmitHandler(Map<Filter, bool> filterMap) {
    _selectedFilters = filterMap;
    filterMeals();
    // print(_selectedFilters);
  }

  void _toggleFavorite(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    // print(meal);
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
  void initState() {
    filterMeals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CategoriesScreen(
      toggle: _toggleFavorite,
      filteredMeal: _availableMeal,
    );

    if (_currentPageIndex == 1) {
      content = MealsScreen(
        null,
        mealList: _favouriteMeals,
        toggle: _toggleFavorite,
      );
    }

    if (_currentPageIndex == 2) {
      content = FilterScreen(
        onFilterSelect: onSubmitHandler,
        defaultFilter: _selectedFilters,
      );
    }

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     'Categories',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.filter), label: 'Filter')
        ],
      ),
    );
  }
}
