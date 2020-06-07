import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/actions.dart';
import 'package:redux/redux.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
  );
}

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(addItemReducer),
  TypedReducer<List<Item>, RemoveItemAction>(removeItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(removeItemsReducer),
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

List<Item> removeItemReducer(List<Item> items, RemoveItemAction action) {
  return List.unmodifiable(List.from(items)..remove(action.item));
}

List<Item> removeItemsReducer(List<Item> items, RemoveItemsAction action) {
  return List.unmodifiable(List.from(items)..remove(action.items));
}

List<Item> getItemReducer(List<Item> items, GetItemsAction action) {
  return <Item>[
    Item(
        kanji: "希望", kana: "", translation: "Hope", state: LearnState.Learning),
    Item(
        kanji: "絶望",
        kana: "",
        translation: "Despair",
        state: LearnState.Learning),
    Item(
        kanji: "未来",
        kana: "",
        translation: "Future",
        state: LearnState.Learned),
    Item(
        kanji: "駅",
        kana: "",
        translation: "Station",
        state: LearnState.Learned),
    Item(
        kanji: "市場",
        kana: "",
        translation: "Market",
        state: LearnState.ToLearn),
    Item(kanji: "犬", kana: "", translation: "Dog", state: LearnState.Learned),
    Item(kanji: "猫", kana: "", translation: "Cat", state: LearnState.Learned),
    Item(
        kanji: "混乱",
        kana: "",
        translation: "Confusion",
        state: LearnState.Learning),
    Item(kanji: "血", kana: "", translation: "Blood", state: LearnState.ToLearn),
  ];
}

List<Item> loadItemsReducer(List<Item> items, LoadedItemsAction action) {
  return action.items;
}

List<Item> selectItemReducer(List<Item> items, SelectItemAction action) {
  return items
      .map((item) =>
          item == action.item ? item.copyWith(isSelected: action.value) : item)
      .toList();
}

List<Item> selectItemsReducer(List<Item> items, SelectItemsAction action) {
  return items
      .map<Item>((item) => item.copyWith(isSelected: action.value))
      .toList();
}
