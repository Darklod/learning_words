import 'dart:convert';

import 'package:learningwords/redux/actions/item.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Non mi serve salvare la lista su disco

void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString("itemsState", string);
}

Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.get("itemsState");

  if (string != null) {
    Map map = json.decode(string);
    return AppState.fromJson(map);
  }

  return AppState.initialState();
}

void appStateMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  if (action is AddItemAction || action is RemoveItemsAction) {
    saveToPrefs(store.state);
  }

  if (action is GetItemsAction) {
    await loadFromPrefs()
        .then((state) => store.dispatch(LoadedItemsAction(state.items)));
  }
}
