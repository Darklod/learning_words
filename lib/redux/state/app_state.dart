import 'package:flutter/material.dart';
import 'package:learningwords/redux/state/errors_state.dart';
import 'package:learningwords/redux/state/settings_state.dart';
import 'package:learningwords/redux/state/words_state.dart';

@immutable
class AppState {
  final WordsState words;
  final SettingsState settings;
  final ErrorState error;

  const AppState({
    @required this.words,
    @required this.settings,
    @required this.error,
  });

  AppState.initialState()
      : words = WordsState.initial(),
        settings = SettingsState.initial(),
        error = ErrorState.initial();

  AppState copyWith({items, settings, error}) {
    return AppState(
      words: items ?? this.words,
      settings: settings ?? this.settings,
      error: error ?? this.error,
    );
  }

  AppState.fromJson(Map json)
      : settings = SettingsState.fromJson(json["settings"] ?? {}),
        words = WordsState.initial(),
        error = ErrorState.initial();

  Map toJson() {
    return {
      // "words": words.toJson(),
      // "error": error.toJson(),
      "settings": settings.toJson(),
    };
  }
}
