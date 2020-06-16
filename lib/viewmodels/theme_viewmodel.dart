import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:learningwords/redux/state/app_state.dart';

class ThemeViewModel {
  final ThemeData themeData;

  const ThemeViewModel({this.themeData});

  factory ThemeViewModel.create(Store<AppState> store) {
    return ThemeViewModel(themeData: store.state.settings.themeData);
  }
}