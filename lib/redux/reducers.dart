import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/redux/items/reducers.dart';
import 'package:learningwords/redux/theme/reducers.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
    themeData: themeReducer(state.themeData, action),
  );
}
