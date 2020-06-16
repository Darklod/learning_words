import 'package:flutter/material.dart';
import 'package:learningwords/screens/add/widgets/labeled_radio.dart';
import 'package:learningwords/widgets/dialogs/custom_action.dart';

class StateDialog extends StatefulWidget {
  final Function onConfirm;

  const StateDialog({Key key, this.onConfirm}) : super(key: key);

  @override
  _StateDialogState createState() => _StateDialogState();
}

class _StateDialogState extends State<StateDialog> {
  final states = ["To Learn", "Learning", "Learned"];
  var _state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      title: const Text("Select State"),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: states.map((s) {
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CustomDialogAction(
          title: "CONFIRM",
          enabled: _state != null,
          onPressed: () {
            var index = 0;
            if (_state != null) {
              index = states.indexOf(_state);
            }
            widget.onConfirm(_state, index);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
