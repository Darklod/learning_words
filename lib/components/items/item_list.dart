import 'package:flutter/material.dart';
import 'package:learningwords/components/items/list_item.dart';
import 'package:learningwords/models/item.dart';

class WordList extends StatelessWidget {
  final Color color;
  final List<Item> list;
  final bool selectionMode;
  final Function(Item, bool) selectItem;

  WordList(this.list, this.color, this.selectionMode, this.selectItem);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemBuilder: (BuildContext context, int index) {
        return ListItem(
          item: list[index],
          color: color,
          selectItem: selectItem,
          selectionMode: selectionMode,
        );
      },
    );
  }
}
