import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DataSearch extends SearchDelegate<String> {
  final words = [
    "kotoba",
    "nihongo",
    "inu",
    "neko",
    "okee",
    "doyoubi",
    "koe",
    "kimi",
    "akai"
  ];

  final recents = ["koe", "kimi", "akai"];

//  @override
//  ThemeData appBarTheme(BuildContext context) {
//    assert(context != null);
//    final ThemeData theme = Theme.of(context);
//    assert(theme != null);
//    return theme;
//  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100),
      alignment: Alignment.topCenter,
      child: Text("No Results"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recents
        : words.where((w) => w.startsWith(query)).toList();

    if (suggestionList.length == 0) {
      return Container(
        padding: EdgeInsets.only(top: 100),
        alignment: Alignment.topCenter,
        child: Text("No Results"),
      );
    }

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Text(suggestionList[index]),
        );
      },
    );
  }
}
