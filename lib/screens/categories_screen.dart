import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.filteredMeal});

  final List<Meal> filteredMeal;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> slideTween;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
        upperBound: 1,
        lowerBound: 0);
    _animationController.forward();

    slideTween = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastEaseInToSlowEaseOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchText = TextEditingController();
    // print(slide.value);

    return Container(
      padding: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1532980400857-e8d9d275d858?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZCUyMHBob3RvZ3JhcGh5fGVufDB8fDB8fHww&w=1000&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
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
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.white70),
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: slideTween,
                  child: child,
                );
              },
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (var item in availableCategories)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      height: 100,
                      child: Card(
                        elevation: 2,
                        child: CategoryItem(
                          colorData: Colors.white,
                          title: item.title,
                          id: item.id,
                          image: item.image,
                          filteredMeal: widget.filteredMeal,
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
