import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatefulWidget {
  const MealItem({super.key, required this.meal});
  final Meal meal;

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> with TickerProviderStateMixin {
  String get complexityData {
    return widget.meal.complexity.name[0].toUpperCase() +
        widget.meal.complexity.name.substring(1);
  }

  String get affordabilityData {
    return widget.meal.affordability.name[0].toUpperCase() +
        widget.meal.affordability.name.substring(1);
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MealDetail(
                  meal: widget.meal,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Hero(
                tag: widget.meal.id,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(widget.meal.imageUrl),
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    color: Colors.black54,
                    child: Column(
                      children: [
                        Text(
                          widget.meal.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MealTrait(
                              icon: Icons.schedule,
                              label: widget.meal.duration.toString(),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            MealTrait(
                              icon: Icons.work,
                              label: complexityData,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            MealTrait(
                              icon: Icons.money,
                              label: affordabilityData,
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
