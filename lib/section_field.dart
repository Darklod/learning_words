import 'package:flutter/material.dart';

abstract class SectionField extends StatelessWidget {
  final String title;
  final double spacing;
  final EdgeInsetsGeometry padding;

  const SectionField({
    Key key,
    @required this.title,
    this.spacing,
    this.padding,
  }) : super(key: key);

  Widget get child => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: spacing),
          child,
        ],
      ),
    );
  }
}

class CustomSectionField extends SectionField {
  final Widget _child;

  CustomSectionField({
    Key key,
    Widget child,
    String title,
    double spacing,
    EdgeInsetsGeometry padding = const EdgeInsets.only(bottom: 32.0),
  })  : _child = child,
        super(key: key, title: title, spacing: spacing, padding: padding);

  @override
  get child => _child;
}

class TextSectionField extends SectionField {
  final String hint;

  TextSectionField({
    Key key,
    this.hint,
    String title,
    double spacing,
    EdgeInsetsGeometry padding = const EdgeInsets.only(bottom: 32.0),
  }) : super(key: key, title: title, spacing: spacing, padding: padding);

  @override
  get child {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: UnderlineInputBorder(),
        filled: false,
      ),
    );
  }
}
