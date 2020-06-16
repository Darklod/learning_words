import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learningwords/app_theme.dart';

@immutable
class SettingsState {
  final ThemeData themeData;

  const SettingsState({@required this.themeData});

  SettingsState.initial() : themeData = AppTheme.lightTheme;

  SettingsState copyWith({ThemeData themeData}) {
    return SettingsState(
      themeData: themeData ?? this.themeData,
    );
  }

  factory SettingsState.fromJson(Map json) {
    return SettingsState(
      themeData:
          json["theme"] == "light" ? AppTheme.lightTheme : AppTheme.darkTheme,
    );
  }

  Map toJson() {
    var theme = "dark";

    if (themeData == AppTheme.lightTheme) {
      theme = "light";
    }

    return {"theme": theme};
  }
}
