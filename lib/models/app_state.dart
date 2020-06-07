import 'package:flutter/foundation.dart';
import 'package:learningwords/models/item.dart';

@immutable
class AppState {
  final List<Item> items;
  final bool selectionMode;

  const AppState({
    @required this.items,
    @required this.selectionMode,
  });

  AppState.initialState()
      : items = List.unmodifiable(<Item>[]),
        selectionMode = false;

  AppState.fromJson(Map json)
      : items = (json["items"] as List).map((i) => Item.fromJson(i)).toList(),
        selectionMode = false;

  Map toJson() {
    return {"items": items};
  }
}
