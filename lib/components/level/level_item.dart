import 'package:flutter/material.dart';
import 'package:learningwords/components/level/level.dart';
import 'package:tinycolor/tinycolor.dart';

class LevelItem extends StatelessWidget {
  final Level level;
  final bool selected;
  final Function onTap;

  const LevelItem({
    @required this.level,
    this.selected = false,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: selected ?  TinyColor(level.color).darken(20).lighten().color : TinyColor(level.color).lighten(10).color,
      textColor: Colors.white,
      disabledColor: Colors.grey[100],
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(level.text),
      ),
    );
  }
}
