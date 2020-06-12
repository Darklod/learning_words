import 'package:flutter/material.dart';
import 'package:learningwords/components/level/level.dart';
import 'package:learningwords/components/level/level_item.dart';

class LevelField extends StatefulWidget {
  final List<Level> levels;
  final String selected;
  final EdgeInsets levelPadding;
  final Function onChange;

  const LevelField({
    @required this.levels,
    this.selected,
    this.levelPadding,
    this.onChange,
    Key key,
  }) : super(key: key);

  @override
  _LevelFieldState createState() => _LevelFieldState();
}

class _LevelFieldState extends State<LevelField> {
  Map<String, bool> _choices = {};

  @override
  void initState() {
    widget.levels.forEach((Level l) {
      _choices[l.text] = false;
    });
    _choices[widget.selected] = true;
    super.initState();
  }

  void _onTap(String newValue) {
    setState(() {
      _choices = _choices.map((key, value) => MapEntry(key, key == newValue));
    });
    widget.onChange(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.levels.map((Level level) {
      return LevelItem(
        level: level,
        padding: widget.levelPadding,
        selected: _choices[level.text],
        onTap: () => _onTap(level.text),
      );
    }).toList();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
