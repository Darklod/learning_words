import 'package:learningwords/redux/middlewares/item.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/redux/reducers/app.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore() {
  return Store<AppState>(
    appStateReducer,
    initialState: AppState.initialState(),
    middleware: []..addAll(itemMiddleware()),
  );
}
