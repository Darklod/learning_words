import 'package:flutter/material.dart';
import 'package:learningwords/screens/add/widgets/labeled_radio.dart';
import 'package:learningwords/widgets/dialogs/custom_action.dart';

class ChoiceDialog extends StatefulWidget {
  final String title;
  final List<String> choices;
  final Function onConfirm;
  final Function onCancel;

  const ChoiceDialog({
    this.title,
    this.choices,
    this.onCancel,
    this.onConfirm,
    Key key,
  }) : super(key: key);

  @override
  _ChoiceDialogState createState() => _ChoiceDialogState();
}

class _ChoiceDialogState extends State<ChoiceDialog> {
  String _state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      title: Text(widget.title),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: widget.choices.map((s) {
            return LabeledRadio<String>(
              label: s,
              value: s,
              groupValue: _state,
              onChanged: (String value) {
                setState(() => _state = value);
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        CustomDialogAction(
          title: "CANCEL",
          onPressed: () => widget.onCancel(),
        ),
        CustomDialogAction(
          title: "CONFIRM",
          enabled: _state != null,
          onPressed: () {
            widget.onConfirm(_state, widget.choices.indexOf(_state));
          },
        )
      ],
    );
  }
}
