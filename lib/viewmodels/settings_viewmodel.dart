import 'package:flutter/material.dart';
import 'package:learningwords/redux/actions/settings_actions.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class SettingsViewModel {
  final ThemeData themeData;
  final Function(ThemeData) toggleTheme;

  SettingsViewModel({this.themeData, this.toggleTheme});

  factory SettingsViewModel.create(Store<AppState> store) {
    _switchTheme(ThemeData theme) {
      store.dispatch(ToggleThemeAction(theme));
    }

    return SettingsViewModel(
      toggleTheme: _switchTheme,
      themeData: store.state.settings.themeData,
    );
  }
}