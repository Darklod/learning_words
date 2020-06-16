import 'package:flutter/material.dart';

class CustomDialogAction extends StatelessWidget {
  final String title;
  final bool enabled;
  final Function onPressed;

  const CustomDialogAction({
    Key key,
    this.title,
    this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: enabled ? onPressed : null,
      padding: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(title),
    );
  }
}
