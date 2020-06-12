import 'package:flutter/material.dart';
import 'package:learningwords/app_theme.dart';
import 'package:learningwords/models/item.dart';

@immutable
class AppState {
  final List<Item> items;
  final ThemeData themeData;

  const AppState({
    @required this.items,
    @required this.themeData,
  });

  AppState.initialState()
      : items = List.unmodifiable(<Item>[]),
        themeData = AppTheme.lightTheme;

  AppState.fromJson(Map json)
      : items = (json["items"] as List).map((i) => Item.fromJson(i)).toList(),
        themeData = (json["theme"] == "light")
            ? AppTheme.lightTheme
            : AppTheme.darkTheme;

  Map toJson() {
    var theme = "dark";

    if (themeData == AppTheme.lightTheme) {
      theme = "light";
    }

    return {"items": items, "theme": theme};
  }
}
