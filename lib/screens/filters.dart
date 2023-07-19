import 'package:flutter/material.dart';
import 'package:meals_app/widgets/switch_listTile.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFreeFliter = false;
  bool _isLactoseFreeFliter = false;
  bool _isVegFilter = false;
  bool _isVegan = false;

  @override
  Widget build(BuildContext context) {
    void setCheck(bool val, String name) {
      if (name == 'Gluten-Free') {
        setState(
          () => _isGlutenFreeFliter = val,
        );
      } else if (name == 'Lactose-Free') {
        setState(() {
          _isLactoseFreeFliter = val;
        });
      } else if (name == 'Vegetarian') {
        setState(() {
          _isVegFilter = val;
        });
      } else if (name == 'Vegan') {
        setState(() {
          _isVegan = val;
        });
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1532980400857-e8d9d275d858?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZCUyMHBob3RvZ3JhcGh5fGVufDB8fDB8fHww&w=1000&q=80'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 25,
            right: 25,
            top: 50,
            bottom: 50,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(children: [
                SwitchListTileTab(
                  title: 'Gluten-Free',
                  subTitle: 'Only include gluten-free meals',
                  filterVal: _isGlutenFreeFliter,
                  onCheckHandler: setCheck,
                ),
                SwitchListTileTab(
                  title: 'Lactose-Free',
                  subTitle: 'Only include lactose-free meals',
                  filterVal: _isLactoseFreeFliter,
                  onCheckHandler: setCheck,
                ),
                SwitchListTileTab(
                  title: 'Vegetarian',
                  subTitle: 'Only include vegetarian meals',
                  filterVal: _isVegFilter,
                  onCheckHandler: setCheck,
                ),
                SwitchListTileTab(
                  title: 'Vegan',
                  subTitle: 'Only include vegan meals',
                  filterVal: _isVegan,
                  onCheckHandler: setCheck,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
