import 'package:flutter/material.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/state/errors_state.dart';
import 'package:learningwords/redux/state/settings_state.dart';

@immutable
class AppState {
  final List<Item> items;
  final SettingsState settings;
  final ErrorState error;

  const AppState({
    @required this.items,
    @required this.settings,
    @required this.error,
  });

  AppState.initialState()
      : items = List.unmodifiable(<Item>[]),
        settings = SettingsState.initial(),
        error = ErrorState.initial();

  AppState copyWith({items, settings, error}) {
    return AppState(
      items: items ?? this.items,
      settings: settings ?? this.settings,
      error: error ?? this.error,
    );
  }

  AppState.fromJson(Map json)
      : items = (json["items"] as List).map((i) => Item.fromJson(i)).toList(),
        settings = SettingsState.fromJson(json["settings"] ?? {}),
        error = ErrorState.fromJson(json["error"] ?? {});

  Map toJson() {
    return {
      "items": items,
      "error": error.toJson(),
      "settings": settings.toJson(),
    };
  }
}
