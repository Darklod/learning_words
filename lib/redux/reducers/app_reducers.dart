import 'package:learningwords/redux/reducers/words_reducers.dart';
import 'package:learningwords/redux/reducers/settings_reducers.dart';
import 'package:learningwords/redux/state/app_state.dart';

import 'errors_reducers.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    words: wordsReducer(state.words, action),
    settings: settingsReducer(state.settings, action),
    error: errorReducer(state.error, action),
  );
}
