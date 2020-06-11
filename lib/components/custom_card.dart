import 'package:flutter/material.dart';

enum Position {
  bottom,
  top,
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color secondaryColor;
  final Position position;
  final Widget label;

  CustomCard({
    @required this.child,
    this.backgroundColor = Colors.white,
    this.secondaryColor = Colors.blue,
    this.position = Position.bottom,
    this.label,
  });

  double get borderSize => 6.0;

  double get bottomSize => position == Position.bottom ? borderSize : 0;

  double get topSize => position == Position.top ? borderSize : 0;

  @override
  Widget build(BuildContext context) {
    const double radius = 8.0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: radius),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: bottomSize, top: topSize),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
            if (label != null) label,
          ],
        ),
      ),
    );
  }
}
