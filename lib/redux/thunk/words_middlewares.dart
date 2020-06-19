import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learningwords/models/word.dart';
import 'package:learningwords/redux/actions/errors_actions.dart';
import 'package:learningwords/redux/actions/words_actions.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/utils.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final _collection = Firestore.instance.collection("words");

StreamSubscription<QuerySnapshot> _stream;

ThunkAction<AppState> initWordsListener() {
  return (Store<AppState> store) async {
    _stream = _collection.snapshots().listen(
      (event) {
        if (event.documentChanges.length > 0) {
          store.dispatch(getWords());
        }
      },
      onDone: () {
        print("onDone");
      },
      onError: (error) {
        print("onError");
        store.dispatch(
          ErrorOccurredAction("Firebase Error: " + error.toString()),
        );
      },
    );

    await store.dispatch(getWords());
  };
}

ThunkAction<AppState> closeWordsListener() {
  return (Store<AppState> store) async {
    await _stream.cancel();
  };
}

ThunkAction<AppState> getWords() {
  return (Store<AppState> store) async {
    //await store.dispatch(checkInternetConnection());
    await store.dispatch(LoadingWordsAction());

    try {
      final snapshot = await _collection.getDocuments();
      final words =
          snapshot.documents.map((d) => Word.fromSnapshot(d)).toList();

      await store.dispatch(LoadedWordsAction(words));
    } catch (e) {
      await store.dispatch(ErrorOccurredAction(e.toString()));
    }
  };
}

ThunkAction<AppState> addWord(Word word) {
  return (Store<AppState> store) async {
    // await store.dispatch(checkInternetConnection());

    final DocumentReference ref = await _collection.add(word.toJson());
    ref..updateData({"id": ref.documentID, "timestamp": currentTimestamp});

    await store.dispatch(getWords());
  };
}

ThunkAction<AppState> deleteWords(List<Word> words) {
  return (Store<AppState> store) async {
    // await store.dispatch(checkInternetConnection());

    final List<String> ids = words.map((word) => word.id).toList();

    ids.forEach((String id) async {
      DocumentSnapshot snapshot = await _collection.document(id).get();
      if (snapshot.exists) {
        await snapshot.reference.delete();
      }
    });

    await store.dispatch(getWords());
  };
}

ThunkAction<AppState> moveWords(List<Word> words, String newState) {
  return (Store<AppState> store) async {
    // await store.dispatch(checkInternetConnection());

    final List<String> ids = words.map((word) => word.id).toList();

    ids.forEach((String id) async {
      DocumentSnapshot snapshot = await _collection.document(id).get();
      if (snapshot.exists) {
        await snapshot.reference.updateData({"state": newState});
      }
    });

    await store.dispatch(getWords());
  };
}
