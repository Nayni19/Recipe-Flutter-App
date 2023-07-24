import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.filteredMeal});

  final List<Meal> filteredMeal;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    var searchText = TextEditingController();
    return Container(
      padding: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1532980400857-e8d9d275d858?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZCUyMHBob3RvZ3JhcGh5fGVufDB8fDB8fHww&w=1000&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SearchBar(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.symmetric(horizontal: 10),
              ),
              leading: const Icon(Icons.search),
              hintText: 'Enter an item',
              controller: searchText,
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.white70),
            ),
          ),
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: availableCategories.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          height: 100,
                          child: Card(
                            elevation: 2,
                            child: CategoryItem(
                              colorData: Colors.white,
                              title: availableCategories[index].title,
                              id: availableCategories[index].id,
                              image: availableCategories[index].image,
                              filteredMeal: widget.filteredMeal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
