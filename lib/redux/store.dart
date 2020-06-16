import 'package:learningwords/redux/reducers/app_reducers.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initialState(),
  middleware: [thunkMiddleware],
);
