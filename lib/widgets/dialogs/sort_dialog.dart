import 'package:flutter/material.dart';
import 'package:learningwords/models/sort_mode.dart';
import 'package:learningwords/screens/add/widgets/labeled_radio.dart';

class SortDialog extends StatelessWidget {
  final String title;
  final String initialChoice;
  final String mode;
  final List<String> choices;
  final Function onConfirm;
  final Function onCancel;

  const SortDialog({
    this.title,
    this.choices,
    this.mode,
    this.initialChoice,
    this.onCancel,
    this.onConfirm,
    Key key,
  }) : super(key: key);

  //widget.onConfirm(_state, widget.choices.indexOf(_state));

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      //insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      title: Text(title),
      children: choices.map((s) {
        var _mode = "ASC";
        return LabeledRadio<String>(
        groupValue: initialChoice,
          label: s,
          value: s,
          toggleable: true,
          leading: initialChoice == s
              ? Icon(mode == "ASC" ? Icons.arrow_upward : Icons.arrow_downward)
              : Container(),
          onChanged: (sort) {
            if (initialChoice == sort) {
              _mode = mode == "ASC" ? "DESC" : "ASC";
            }

            onConfirm(sort, _mode);
          },
        );
      }).toList(),
    );
  }
}
