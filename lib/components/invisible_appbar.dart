import 'package:flutter/material.dart';

class InvisibleAppBar extends StatelessWidget {
  final String title;
  final Function onSave;

  const InvisibleAppBar({Key key, this.title, this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
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
          IconButton(
            onPressed: onSave,
            icon: Icon(Icons.check),
            tooltip: "Save",
          ),
        ],
      ),
    );
  }
}
