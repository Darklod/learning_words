import 'package:flutter/material.dart';
import 'package:learningwords/components/items/item_list.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/view_model.dart';

class ItemsTab extends StatelessWidget {
  final List<Item> items;
  final Color color;
  final ViewModel model;

  ItemsTab({this.model, this.items, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    items.length.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_downward, size: 18),
                      Text(
                        "名前",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.0).copyWith(bottom: 0),
            ),
            WordList(model, items, color),
          ],
        ),
      ),
    );
  }
}
