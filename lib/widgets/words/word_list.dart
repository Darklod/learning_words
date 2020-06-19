import 'package:flutter/material.dart';
import 'package:learningwords/models/word.dart';
import 'package:learningwords/widgets/words/list_item.dart';

class WordList extends StatelessWidget {
  final Color color;
  final List<Word> list;
  final bool selectionMode;
  final Function(Word, bool) selectItem;

  WordList(this.list, this.color, this.selectionMode, this.selectItem);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16, 0, 16, 80),
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
