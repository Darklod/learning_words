import 'package:flutter/material.dart';
import 'package:learningwords/components/labeled_radio.dart';
import 'package:learningwords/models/item.dart';

class StateDialog extends StatefulWidget {
  final Function onConfirm;
  final Function onCancel;

  const StateDialog({Key key, this.onConfirm, this.onCancel}) : super(key: key);

  @override
  _StateDialogState createState() => _StateDialogState();
}

class _StateDialogState extends State<StateDialog> {
  var _state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      titleTextStyle:
          Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.black87),
      title: Text("Select State"),
      content: StatefulBuilder(builder: (_, StateSetter setState) {
        final states = ["Learned", "Learning", "To Learn"];

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: states.map((s) {
            return LabeledRadio<LearnState>(
              label: s,
              value: LearnState.values[states.indexOf(s)],
              groupValue: _state,
              onChanged: (LearnState value) {
                setState(() => _state = value);
              },
            );
          }).toList(),
        );
      }),
      actions: <Widget>[
        _CustomAction(
          title: "CANCEL",
          onPressed: widget.onCancel,
        ),
        _CustomAction(
          title: "CONFIRM",
          onPressed: () => widget.onConfirm(_state),
        )
      ],
    );
  }
}

class _CustomAction extends StatelessWidget {
  final String title;
  final Function onPressed;

  const _CustomAction({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Theme.of(context).primaryColor)),
    );
  }
}
