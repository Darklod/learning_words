import 'package:learningwords/redux/reducers/item.dart';
import 'package:learningwords/redux/reducers/settings.dart';
import 'package:learningwords/models/app_state.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
    themeData: themeReducer(state.themeData, action),
  );
}
