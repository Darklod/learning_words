import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/actions/item.dart';
import 'package:learningwords/models/app_state.dart';
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
    store.dispatch(LoadingItemsAction());

    final snapshot = await _collection.getDocuments();
    final items = snapshot.documents.map((d) => Item.fromSnapshot(d)).toList();

    await store.dispatch(LoadedItemsAction(items));
  };
}

ThunkAction<AppState> addItem(Item item) {
  return (Store<AppState> store) async {
    final DocumentReference ref = await _collection.add(item.toJson());
    ref..updateData({"id": ref.documentID});

    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> deleteItems(List<Item> items) {
  return (Store<AppState> store) async {
    final List<String> ids = items.map((item) => item.id).toList();

    // TODO: combine snapshots
    ids.forEach((String id) async {

    });

    final snapshot = await _collection.where("id", whereIn: ids).getDocuments();

    snapshot.documents.forEach((DocumentSnapshot d) async {
      await d.reference.delete();
    });

    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> moveItems(List<Item> items, String newState) {
  return (Store<AppState> store) async {
    final List<String> ids = items.map((item) => item.id).toList();

    final snapshot = await _collection.where("id", whereIn: ids).getDocuments();

    snapshot.documents.forEach((DocumentSnapshot d) async {
      await d.reference.updateData({"state": newState});
    });

    await store.dispatch(getItems());
  };
}
