import 'package:meals_app/data/meals_data.dart';
import 'package:riverpod/riverpod.dart';

final mealProvider = Provider((ref) => dummyMeals);
