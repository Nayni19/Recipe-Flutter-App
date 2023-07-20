import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.toggle, required this.filteredMeal});
  final Function toggle;

  final List<Meal> filteredMeal;

  @override
  Widget build(BuildContext context) {
    var searchText = TextEditingController();

    return Container(
      padding: EdgeInsets.only(top: 50),
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SearchBar(
              padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.symmetric(horizontal: 10),
              ),
              leading: Icon(Icons.search),
              hintText: 'Enter an item',
              controller: searchText,
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.white70),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (var item in availableCategories)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    height: 100,
                    child: Card(
                      elevation: 2,
                      child: CategoryItem(
                        toggle: toggle,
                        colorData: Colors.white,
                        title: item.title,
                        id: item.id,
                        image: item.image,
                        filteredMeal: filteredMeal,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
