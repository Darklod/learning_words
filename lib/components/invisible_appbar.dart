import 'package:flutter/material.dart';

class InvisibleAppBar extends StatelessWidget {
  final String title;

  const InvisibleAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            tooltip: "Back",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(width: 40.0),
        ],
      ),
    );
  }
}
