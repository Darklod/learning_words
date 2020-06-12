import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:learningwords/components/custom_card.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/view_model.dart';

class ListItem extends StatefulWidget {
  final Item item;
  final Color color;
  final ViewModel model;

  const ListItem({
    @required this.item,
    @required this.color,
    @required this.model,
  });

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  Item get item => widget.item;

  Color get color => widget.color;

  ViewModel get model => widget.model;

  void _onLongPress() {
    model.selectItem(item, !item.isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      child: GestureDetector(
        onLongPress: _onLongPress,
        onTap: model.selectionMode ? _onLongPress : null,
        child: FlipCard(
          direction: FlipDirection.VERTICAL,
          flipOnTouch: !model.selectionMode,
          front: CustomCard(
            backgroundColor: item.isSelected ? color : Colors.white,
            secondaryColor: color,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.kanji,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color:
                              item.isSelected ? Colors.white : Colors.black87,
                        ),
                  ),
                  Text(
                    item.jlpt,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color:
                              item.isSelected ? Colors.white : Colors.black87,
                        ),
                  ),
                ],
              ),
            ),
          ),
          back: CustomCard(
            backgroundColor: color,
            secondaryColor: Colors.white,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item.translation,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
