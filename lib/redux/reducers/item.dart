import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/actions/item.dart';
import 'package:redux/redux.dart';

Reducer<List<Item>> itemReducer = combineReducers<List<Item>>([
  TypedReducer<List<Item>, LoadedItemsAction>(_loadItemsReducer),
  TypedReducer<List<Item>, SelectItemAction>(_selectItemReducer),
  TypedReducer<List<Item>, SelectItemsAction>(_selectItemsReducer),
]);

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
