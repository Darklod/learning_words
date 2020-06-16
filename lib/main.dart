import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/redux/store.dart';
import 'package:learningwords/redux/thunk/items_middlewares.dart';
import 'package:learningwords/routes.dart';
import 'package:redux/redux.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  const App({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        onInit: (store) => store.dispatch(initItemsListener()),
        onDispose: (store) => store.dispatch(closeItemsListener()),
        builder: (BuildContext context, _ViewModel vm) {
          return MaterialApp(
            title: 'Words',
            locale: Locale('ja', 'JP'),
            theme: vm.themeData,
            initialRoute: homeRoute,
            onGenerateRoute: Router.generateRoute,
          );
        },
      ),
    );
  }
}

class _ViewModel {
  final ThemeData themeData;

  _ViewModel({this.themeData});

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(themeData: store.state.settings.themeData);
  }
}
