import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';

class MealDetail extends StatelessWidget {
  const MealDetail({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              left: 25,
              right: 25,
              bottom: 50,
              top: 100,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white38,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingredients',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        children: [
                          for (var ingredient in meal.ingredients)
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                              ),
                              child: Text(
                                ingredient,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Steps to Prepare',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      for (var step in meal.steps)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            step,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                          ),
                        )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
