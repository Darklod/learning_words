import 'package:flutter/material.dart';

class SortListItem extends StatelessWidget {
  final bool asc;
  final String text;
  final bool selected;
  final Function onTap;

  const SortListItem(this.asc, this.text, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: selected ? Theme.of(context).primaryColor.withOpacity(0.8) : Colors.white,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                asc ? Icons.arrow_upward : Icons.arrow_downward,
                color: selected ? Colors.white : Colors.black54,
              ),
              SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
