import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final bool selectionMode;
  final Function onPressed;

  const CustomFAB({
    Key key,
    @required this.selectionMode,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectionMode) return Container();

    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text("Insert"),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      onPressed: onPressed,
    );
  }
}