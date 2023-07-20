import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.colorData,
      required this.title,
      required this.id,
      required this.image,
      required this.toggle,
      required this.filteredMeal});

  final Function toggle;
  final Color colorData;
  final String title;
  final String id;
  final String image;
  final List<Meal> filteredMeal;
  @override
  Widget build(BuildContext context) {
    void selectedMeals() {
      List<Meal> filteredList =
          filteredMeal.where((meal) => meal.categories.contains(id)).toList();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MealsScreen(
            title,
            mealList: filteredList,
            toggle: toggle,
          ),
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
        // padding: EdgeInsets.all(10),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorData,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(1, 1)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(
              image,
              width: 120,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
