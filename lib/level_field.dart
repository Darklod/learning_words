import 'package:flutter/material.dart';
import 'package:learningwords/level.dart';
import 'package:learningwords/level_item.dart';

class LevelField extends StatefulWidget {
  final List<Level> levels;
  final int selected;
  final Axis direction;
  final Function onChange;

  const LevelField(
      {@required this.levels,
      this.selected,
      this.onChange,
      this.direction,
      Key key})
      : super(key: key);

  @override
  _LevelFieldState createState() => _LevelFieldState();
}

class _LevelFieldState extends State<LevelField> {
  var _isSelected;

  @override
  void initState() {
    _isSelected = List<bool>.filled(widget.levels.length, false);
    _isSelected[widget.selected] = true;
    super.initState();
  }

  void _onTap(int index) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = index == i;
      }
    });
    widget.onChange(index);
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.levels
        .asMap()
        .map(
          (int index, Level level) {
            return MapEntry(
              index,
              LevelItem(
                level: level,
                selected: _isSelected[index],
                onTap: () => _onTap(index),
              ),
            );
          },
        )
        .values
        .toList();

    if (widget.direction == Axis.vertical)
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      );

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
