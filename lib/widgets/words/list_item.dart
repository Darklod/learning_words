import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:learningwords/models/word.dart';
import 'package:learningwords/widgets/custom_card.dart';

class ListItem extends StatefulWidget {
  final Word item;
  final Color color;
  final bool selectionMode;
  final Function(Word, bool) selectItem;

  ListItem({
    @required this.item,
    @required this.color,
    this.selectionMode = false,
    @required this.selectItem,
  });

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  Word get item => widget.item;

  Color get color => widget.color;

  void _onLongPress() {
    widget.selectItem(item, !item.isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      child: GestureDetector(
        onLongPress: _onLongPress,
        onTap: widget.selectionMode ? _onLongPress : null,
        child: FlipCard(
          direction: FlipDirection.VERTICAL,
          flipOnTouch: !widget.selectionMode,
          front: CustomCard(
            backgroundColor: item.isSelected ? color : Colors.white,
            secondaryColor: color,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.kanji,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: item.isSelected
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                      ),
                      Text(
                        item.kana,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: item.isSelected
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                      ),
                    ],
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
