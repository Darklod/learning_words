import 'package:flutter/material.dart';
import 'package:learningwords/components/level/level.dart';

class LevelItem extends StatelessWidget {
  final Level level;
  final bool selected;
  final EdgeInsets padding;
  final Function onTap;

  const LevelItem({
    @required this.level,
    this.selected = false,
    this.padding,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: selected ? level.color : Colors.grey[300],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding: padding,
            child: Text(
              level.text,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: selected ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
