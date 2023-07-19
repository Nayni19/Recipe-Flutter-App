import 'package:flutter/material.dart';
import 'package:meals_app/data/meals_data.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.colorData,
      required this.title,
      required this.id});

  final Color colorData;
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    void selectedMeals() {
      List<Meal> filteredList =
          dummyMeals.where((meal) => meal.categories.contains(id)).toList();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              MealsScreen(title: title, mealList: filteredList),
        ),
      );
    }

    return InkWell(
      onTap: () {
        selectedMeals();
      },
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorData.withOpacity(0.55), colorData.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(1, 1)),
          ],
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
