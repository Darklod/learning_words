import 'package:flutter/material.dart';
import 'package:learningwords/components/level/level.dart';

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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: selected ? level.color : level.color.withOpacity(0.5),
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