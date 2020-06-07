import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningwords/list_item.dart';

class WordList extends StatelessWidget{
  final Color color;
  final List<Map> list;
  final bool selectionMode;
  final Function onSelect;

  WordList(this.list, this.color, this.selectionMode, this.onSelect);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemBuilder: (BuildContext context, int index) {
        return ListItem(
          item: list[index],
          color: color,
          selectionMode: selectionMode,
          onSelected: () => onSelect(index),
        );
      },
    );
  }
}
