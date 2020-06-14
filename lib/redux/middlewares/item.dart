import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/actions/item.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> itemMiddleware() {
  return [
    TypedMiddleware<AppState, AddItemAction>(_addItem),
    TypedMiddleware<AppState, RemoveItemsAction>(_removeItems),
    TypedMiddleware<AppState, MoveItemsAction>(_moveItems),
    TypedMiddleware<AppState, GetItemsAction>(_getItems),
  ];
}

final _collection = Firestore.instance.collection("items");

_addItem(
    Store<AppState> store, AddItemAction action, NextDispatcher next) async {
  final DocumentReference ref = await _collection.add(action.item.toJson());
  ref..updateData({"id": ref.documentID});

  next(action);
}

_removeItems(Store<AppState> store, RemoveItemsAction action,
    NextDispatcher next) async {
  final List<String> ids = action.items.map((item) => item.id).toList();

  final snapshot = await _collection.where("id", whereIn: ids).getDocuments();

  snapshot.documents.forEach((DocumentSnapshot d) async {
    await d.reference.delete();
  });

  next(action);
}

_moveItems(
    Store<AppState> store, MoveItemsAction action, NextDispatcher next) async {
  final List<String> ids = action.items.map((item) => item.id).toList();

  final snapshot = await _collection.where("id", whereIn: ids).getDocuments();

  snapshot.documents.forEach((DocumentSnapshot d) async {
    await d.reference.updateData({"state": action.newState});
  });

  next(action);
}

_getItems(
    Store<AppState> store, GetItemsAction action, NextDispatcher next) async {
  // must be disposed
  _collection.snapshots().listen((event) {
    event.documentChanges.forEach((docChange) {
      Item item = Item.fromJson(docChange.document.data);

      if (docChange.type == DocumentChangeType.added) {
        store.dispatch(AddItemAction(item));
      }
      if (docChange.type == DocumentChangeType.removed) {
        store.dispatch(RemoveItemsAction([item]));
      }
      if (docChange.type == DocumentChangeType.modified) {}
    });
  });

  next(action);

  final snapshot = await _collection.getDocuments();
  final items = snapshot.documents.map((e) => Item.fromJson(e.data)).toList();

  store.dispatch(LoadedItemsAction(items));
}
