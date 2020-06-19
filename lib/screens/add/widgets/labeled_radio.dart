import 'package:flutter/material.dart';

class LabeledRadio<T> extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final T groupValue;
  final T value;
  final bool toggleable;
  final Function onChanged;
  final Widget leading;

  const LabeledRadio({
    this.label,
    this.padding = EdgeInsets.zero,
    this.groupValue,
    this.value,
    this.toggleable = false,
    this.onChanged,
    this.leading,
  });

  _onTap() {
    if (value != groupValue || toggleable) {
      onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: _onTap,
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<T>(
              groupValue: groupValue,
              value: value,
              onChanged: (T newValue) => _onTap(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label, style: Theme.of(context).textTheme.bodyText1),
            ),
            leading ?? Container(),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
