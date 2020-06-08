import 'package:flutter/material.dart';
import 'package:learningwords/components/items/list_item.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/view_model.dart';

class WordList extends StatelessWidget {
  final Color color;
  final List<Item> list;
  final ViewModel model;

  WordList(this.model, this.list, this.color);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemBuilder: (BuildContext context, int index) {
        return ListItem(item: list[index], color: color, model: model);
      },
    );
  }
}
