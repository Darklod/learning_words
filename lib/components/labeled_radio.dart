import 'package:flutter/material.dart';

class LabeledRadio<T> extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final T groupValue;
  final T value;
  final Function onChanged;

  const LabeledRadio({
    this.label,
    this.padding = EdgeInsets.zero,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<T>(
              groupValue: groupValue,
              value: value,
              onChanged: (T newValue) => onChanged(newValue),
            ),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
