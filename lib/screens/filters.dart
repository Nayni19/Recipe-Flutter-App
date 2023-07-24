import 'package:flutter/material.dart';
import 'package:meals_app/widgets/switch_listTile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filters_provider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
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
    final filter = ref.watch(filterProvider.notifier);
    final activeFilter = ref.watch(filterProvider);

    Map<String, Filter> filterData = {
      'Gluten-Free': Filter.glutenFree,
      'Lactose-Free': Filter.lactoseFree,
      'Vegetarian': Filter.vegetarian,
      'Vegan': Filter.vegan
    };

    void setCheck(String filterVal, bool val) {
      filter.setFilter(filterData[filterVal]!, val);
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
            child: ScaleTransition(
              scale: _animation,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(children: [
                  SwitchListTileTab(
                    title: 'Gluten-Free',
                    subTitle: 'Only include gluten-free meals',
                    filterVal: activeFilter[Filter.glutenFree]!,
                    onCheckHandler: setCheck,
                  ),
                  SwitchListTileTab(
                    title: 'Lactose-Free',
                    subTitle: 'Only include lactose-free meals',
                    filterVal: activeFilter[Filter.lactoseFree]!,
                    onCheckHandler: setCheck,
                  ),
                  SwitchListTileTab(
                    title: 'Vegetarian',
                    subTitle: 'Only include vegetarian meals',
                    filterVal: activeFilter[Filter.vegetarian]!,
                    onCheckHandler: setCheck,
                  ),
                  SwitchListTileTab(
                    title: 'Vegan',
                    subTitle: 'Only include vegan meals',
                    filterVal: activeFilter[Filter.vegan]!,
                    onCheckHandler: setCheck,
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
