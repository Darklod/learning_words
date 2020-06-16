import 'package:connectivity/connectivity.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> checkInternetConnection() {
  return (Store<AppState> store) async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      // TODO: store.dispatch(ShowErrorAction);
      // TODO: start listening
      // TODO: when connection detected dispatch(getItems())
    }
  };
}
