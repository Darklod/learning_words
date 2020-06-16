import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/actions/errors_actions.dart';
import 'package:learningwords/redux/actions/items_actions.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final _collection = Firestore.instance.collection("items");

StreamSubscription<QuerySnapshot> _stream;

ThunkAction<AppState> initItemsListener() {
  return (Store<AppState> store) async {
    _stream = _collection.snapshots().listen((event) {
      event.documentChanges.forEach((_) async {
        await store.dispatch(getItems());
      });
    });

    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> closeItemsListener() {
  return (Store<AppState> store) async {
    await _stream.cancel();
  };
}

ThunkAction<AppState> getItems() {
  return (Store<AppState> store) async {
    //await store.dispatch(checkInternetConnection());
    await store.dispatch(LoadingItemsAction());

    try {
      final snapshot = await _collection.getDocuments();
      final items =
          snapshot.documents.map((d) => Item.fromSnapshot(d)).toList();
      await store.dispatch(LoadedItemsAction(items));
    } catch (e) {
      await store.dispatch(ErrorOccurredAction(e.toString()));
    }

    // TODO: if error dispatch(ErrorAction(message));
    // TODO:  set error state (message, blah, ..., error: true)
    // TODO:  view -> if store.state.error -> show something (SnakeBar)
  };
}

ThunkAction<AppState> addItem(Item item) {
  return (Store<AppState> store) async {
    // await store.dispatch(checkInternetConnection());

    final DocumentReference ref = await _collection.add(item.toJson());
    ref..updateData({"id": ref.documentID});

    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> deleteItems(List<Item> items) {
  return (Store<AppState> store) async {
    // await store.dispatch(checkInternetConnection());

    final List<String> ids = items.map((item) => item.id).toList();

    ids.forEach((String id) async {
      DocumentSnapshot snapshot = await _collection.document(id).get();
      if (snapshot.exists) {
        await snapshot.reference.delete();
      }
    });

    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> moveItems(List<Item> items, String newState) {
  return (Store<AppState> store) async {
    // await store.dispatch(checkInternetConnection());

    final List<String> ids = items.map((item) => item.id).toList();

    ids.forEach((String id) async {
      DocumentSnapshot snapshot = await _collection.document(id).get();
      if (snapshot.exists) {
        await snapshot.reference.updateData({"state": newState});
      }
    });

    await store.dispatch(getItems());
  };
}
