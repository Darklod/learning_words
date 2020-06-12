import 'package:flutter/material.dart';
import 'package:learningwords/redux/theme/actions.dart';
import 'package:redux/redux.dart';

final themeReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, ToggleThemeAction>(refreshReducer),
]);

ThemeData refreshReducer(ThemeData themeData, ToggleThemeAction action) {
  return action.theme;
}
