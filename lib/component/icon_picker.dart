import 'package:flutter/material.dart';
import 'package:todo/component/todo_badge.dart';

class IconPicker extends StatefulWidget {
  final ValueChanged<IconData> onIconChanged;
  final IconData currentIconData;
  final Color highlightColor, unHighlightColor;

  final List<IconData> icons = [
    Icons.home,
    Icons.work,
    Icons.games,
    Icons.shop,
    Icons.subway,
  ];

  IconPicker({
    @required this.currentIconData,
    @required this.onIconChanged,
    Color highlightColor,
    Color unHighlightColor,
  })  : this.highlightColor = highlightColor ?? Colors.red,
        this.unHighlightColor = unHighlightColor ?? Colors.blueGrey;

  @override
  State<StatefulWidget> createState() {
    return _IconPickerState();
  }
}

class _IconPickerState extends State<IconPicker> {
  IconData selectedIconData;

  @override
  void initState() {
    selectedIconData = widget.currentIconData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      width: orientation == Orientation.portrait ? 300.0 : 300.0,
      height: orientation == Orientation.portrait ? 360.0 : 200.0,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        children: widget.icons.map((IconData iconData) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIconData = iconData;
              });
              widget.onIconChanged(iconData);
            },
            borderRadius: BorderRadius.circular(50.0),
            child: TodoBadge(
              id: iconData.hashCode.toString(),
              codePoint: iconData.codePoint,
              color: iconData == selectedIconData
                  ? widget.highlightColor
                  : widget.unHighlightColor,
              size: 32,
            ),
          );
        }).toList(),
      ),
    );
  }
}