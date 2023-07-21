import 'package:flutter/material.dart';

class SwitchListTileTab extends StatefulWidget {
  const SwitchListTileTab(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.filterVal,
      required this.onCheckHandler});
  final String title;
  final String subTitle;
  final bool filterVal;
  final Function onCheckHandler;
  @override
  State<SwitchListTileTab> createState() => _SwitchListTileTabState();
}

class _SwitchListTileTabState extends State<SwitchListTileTab> {
  @override
  Widget build(BuildContext context) {
    var kTitleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold);

    var kSubTitleStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer);

    return SwitchListTile(
      value: widget.filterVal,
      onChanged: (isChecked) =>
          {widget.onCheckHandler(widget.title, isChecked)},
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Text(widget.title, style: kTitleStyle),
      subtitle: Text(
        widget.subTitle,
        style: kSubTitleStyle,
      ),
      activeTrackColor: Color.fromARGB(255, 28, 44, 59),
    );
  }
}
