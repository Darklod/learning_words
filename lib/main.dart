import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/redux/store.dart';
import 'package:learningwords/redux/thunk/words_middlewares.dart';
import 'package:learningwords/routes.dart';
import 'package:learningwords/viewmodels/theme_viewmodel.dart';
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
      child: StoreConnector<AppState, ThemeViewModel>(
        converter: (Store<AppState> store) => ThemeViewModel.create(store),
        onInit: (store) => store.dispatch(initWordsListener()),
        onDispose: (store) => store.dispatch(closeWordsListener()),
        builder: (BuildContext context, ThemeViewModel vm) {
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
