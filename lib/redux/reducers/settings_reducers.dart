import 'package:learningwords/redux/actions/settings_actions.dart';
import 'package:learningwords/redux/state/settings_state.dart';
import 'package:redux/redux.dart';

final settingsReducer = combineReducers<SettingsState>([
  TypedReducer<SettingsState, ToggleThemeAction>(_toggleThemeReducer),
]);

SettingsState _toggleThemeReducer(
    SettingsState settingsState, ToggleThemeAction action) {
  return settingsState.copyWith(themeData: action.theme);
}
