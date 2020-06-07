import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningwords/custom_card.dart';

class ListItem extends StatefulWidget {
  final Map item; //
  final Color color;
  final bool isSelected;
  final bool selectionMode;
  final Function onSelected;

  const ListItem({
    @required this.item,
    @required this.color,
    this.isSelected = false,
    this.selectionMode = false,
    this.onSelected,
  });

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  var _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  void _onLongPress() {
    setState(() {
      _isSelected = true;
    });

    if (!widget.onSelected()) {
      setState(() {
        _isSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      height: 96,
      child: GestureDetector(
        onLongPress: _onLongPress,
        onTap: widget.selectionMode ? _onLongPress : null,
        child: FlipCard(
          direction: FlipDirection.VERTICAL,
          flipOnTouch: !widget.selectionMode,
          front: CustomCard(
            backgroundColor: _isSelected ? widget.color : Colors.white,
            secondaryColor: widget.color,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.item["kanji"],
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: _isSelected ? Colors.white : Colors.black87,
                        ),
                  ),
                  Text(
                    "N" + (Random().nextInt(5) + 1).toString(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: _isSelected ? Colors.white : Colors.black87,
                        ),
                  ),
                ],
              ),
            ),
          ),
          back: CustomCard(
            backgroundColor: widget.color,
            secondaryColor: Colors.white,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.item["trad"],
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
