import 'package:flutter/foundation.dart';
import 'package:learningwords/models/item.dart';

@immutable
class AppState {
  final List<Item> items;

  const AppState({
    @required this.items,
  });

  AppState.initialState() : items = List.unmodifiable(<Item>[]);

  AppState.fromJson(Map json)
      : items = (json["items"] as List).map((i) => Item.fromJson(i)).toList();

  Map toJson() {
    return {"items": items};
  }
}
