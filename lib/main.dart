import 'package:flutter/material.dart';

import 'package:learningwords/app_theme.dart';
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
      child: MaterialApp(
        title: 'Words',
        locale: Locale('ja', 'JP'),
        theme: AppTheme.lightTheme,
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetItemsAction()),
          builder: (BuildContext context, Store<AppState> store) {
            return HomePage();
          },
        ),
      ),
    );
  }
}

// TODO: tema scuro: blu-nerissimo e teal e bianco
// (https://dribbble.com/shots/9150888-Project-Management-App-Concept-2/attachments/1197627?mode=media)
// TODO: https://pub.dev/packages/swipeable_card (per le review)
