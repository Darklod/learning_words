import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/actions/item.dart';
import 'package:redux/redux.dart';

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, AddItemAction>(_addItemReducer),
  TypedReducer<List<Item>, RemoveItemsAction>(_removeItemsReducer),
  TypedReducer<List<Item>, MoveItemsAction>(_moveItemsReducer),
  TypedReducer<List<Item>, LoadedItemsAction>(_loadItemsReducer),
  //TypedReducer<List<Item>, GetItemsAction>(_getItemReducer),
  TypedReducer<List<Item>, SelectItemAction>(_selectItemReducer),
  TypedReducer<List<Item>, SelectItemsAction>(_selectItemsReducer),
]);

List<Item> _addItemReducer(List<Item> items, AddItemAction action) {
  return []
    ..addAll(items)
    ..add(action.item);
}

List<Item> _removeItemsReducer(List<Item> items, RemoveItemsAction action) {
  final List<String> ids = action.items.map((i) => i.id).toList();

  return items.where((i) => !ids.contains(i.id)).toList();
}

List<Item> _moveItemsReducer(List<Item> items, MoveItemsAction action) {
  final List<String> ids = action.items.map((i) => i.id).toList();

  return items
      .map((item) => ids.contains(item.id)
          ? item = item.copyWith(state: action.newState, isSelected: false)
          : item)
      .toList();
}

List<Item> _getItemReducer(List<Item> items, GetItemsAction action) {
  return <Item>[];
}

List<Item> _loadItemsReducer(List<Item> items, LoadedItemsAction action) {
  return action.items;
}

List<Item> _selectItemReducer(List<Item> items, SelectItemAction action) {
  return items
      .map((item) => item.id == action.item.id
          ? item.copyWith(isSelected: action.value)
          : item)
      .toList();
}

List<Item> _selectItemsReducer(List<Item> items, SelectItemsAction action) {
  return items.map((item) => item.copyWith(isSelected: action.value)).toList();
}
