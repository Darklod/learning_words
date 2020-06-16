import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/redux/reducers/app.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Store<AppState> createStore() {
  return Store<AppState>(
    appStateReducer,
    initialState: AppState.initialState(),
    middleware: [thunkMiddleware],
  );
}
