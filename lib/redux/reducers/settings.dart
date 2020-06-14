import 'package:flutter/material.dart';
import 'package:learningwords/redux/actions/settings.dart';
import 'package:redux/redux.dart';

final themeReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, ToggleThemeAction>(_refreshReducer),
]);

ThemeData _refreshReducer(ThemeData themeData, ToggleThemeAction action) {
  return action.theme;
}
