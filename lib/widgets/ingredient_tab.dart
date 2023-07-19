import 'package:flutter/material.dart';

class IngredientTab extends StatelessWidget {
  const IngredientTab({
    super.key,
    required this.ingredient,
  });

  final String ingredient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.black45,
      ),
      child: Text(
        ingredient,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
