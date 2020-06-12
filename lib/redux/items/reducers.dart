import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/items/actions.dart';
import 'package:redux/redux.dart';

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(removeItemsReducer),
  TypedReducer<List<Item>, MoveItemsAction>(moveItemsReducer),
  TypedReducer<List<Item>, LoadedItemsAction>(loadItemsReducer),
  TypedReducer<List<Item>, GetItemsAction>(getItemReducer),
  TypedReducer<List<Item>, SelectItemAction>(selectItemReducer),
  TypedReducer<List<Item>, SelectItemsAction>(selectItemsReducer),
]);

List<Item> addItemReducer(List<Item> items, AddItemAction action) {
  return []
    ..addAll(items)
    ..add(action.item);
}

List<Item> removeItemsReducer(List<Item> items, RemoveItemsAction action) {
  final List<String> ids = action.items.map((i) => i.id).toList();

  return List.unmodifiable(
      List<Item>.from(items)..removeWhere((i) => ids.contains(i.id)));
}

List<Item> moveItemsReducer(List<Item> items, MoveItemsAction action) {
  final List<String> ids = action.items.map((i) => i.id).toList();

  return items
      .map((item) => ids.contains(item.id)
          ? item = item.copyWith(state: action.newState, isSelected: false)
          : item)
      .toList();
}

List<Item> getItemReducer(List<Item> items, GetItemsAction action) {
  return <Item>[
    Item(
      id: "1",
      kanji: "希望",
      kana: "",
      translation: "Hope",
      state: "Learning",
      jlpt: "N3",
    ),
    Item(
      id: "2",
      kanji: "絶望",
      kana: "",
      translation: "Despair",
      state: "Learning",
      jlpt: "N3",
    ),
    Item(
      id: "3",
      kanji: "未来",
      kana: "",
      translation: "Future",
      state: "Learned",
      jlpt: "N4",
    ),
    Item(
      id: "4",
      kanji: "駅",
      kana: "",
      translation: "Station",
      state: "Learned",
      jlpt: "N5",
    ),
    Item(
      id: "5",
      kanji: "市場",
      kana: "",
      translation: "Market",
      state: "To Learn",
      jlpt: "N4",
    ),
    Item(
      id: "6",
      kanji: "犬",
      kana: "",
      translation: "Dog",
      state: "Learned",
      jlpt: "N5",
    ),
    Item(
      id: "7",
      kanji: "猫",
      kana: "",
      translation: "Cat",
      state: "Learned",
      jlpt: "N5",
    ),
    Item(
      id: "8",
      kanji: "混乱",
      kana: "",
      translation: "Confusion",
      state: "Learning",
      jlpt: "N3",
    ),
    Item(
      id: "9",
      kanji: "血",
      kana: "",
      translation: "Blood",
      state: "To Learn",
      jlpt: "N3",
    ),
  ];
}

List<Item> loadItemsReducer(List<Item> items, LoadedItemsAction action) {
  return action.items;
}

List<Item> selectItemReducer(List<Item> items, SelectItemAction action) {
  return items
      .map((item) => item.id == action.item.id
          ? item.copyWith(isSelected: action.value)
          : item)
      .toList();
}

List<Item> selectItemsReducer(List<Item> items, SelectItemsAction action) {
  return items.map((item) => item.copyWith(isSelected: action.value)).toList();
}
