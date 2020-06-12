import 'package:flutter/material.dart';
import 'package:learningwords/pages/home.dart';

import 'package:learningwords/redux/actions.dart';
import 'package:learningwords/redux/reducers.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'models/app_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initialState(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel vm) {
          return MaterialApp(
            title: 'Words',
            locale: Locale('ja', 'JP'),
            theme: vm.themeData,
            home: StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(GetItemsAction()),
              builder: (BuildContext context, Store<AppState> store) {
                return HomePage();
              },
            ),
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
    return _ViewModel(
      themeData: store.state.themeData,
    );
  }
}
