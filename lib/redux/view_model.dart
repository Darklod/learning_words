import 'package:redux/redux.dart';
import 'package:learningwords/redux/actions.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/models/item.dart';

class ViewModel {
  final List<Item> items;
  final List<Item> learnedItems;
  final List<Item> toLearnItems;
  final List<Item> learningItems;
  final Function(Item) onAddItem;
  final Function() onDelete;
  final Function(LearnState) onMove;
  final Function(Item, bool) selectItem;
  final Function(bool) selectAll;
  final int selectionCount;
  final bool selectionMode;

  ViewModel({
    this.items, // Search, Home
    this.selectionMode, // Home, Item
    this.selectionCount, // Home
    this.learnedItems,  // Home
    this.toLearnItems,  // Home
    this.learningItems, // Home
    this.onAddItem, // AddPage
    this.onDelete, // Home
    this.onMove, // Home
    this.selectItem, // Item
    this.selectAll,  // Home
  });

  factory ViewModel.create(Store<AppState> store) {
    _filterSelected(List<Item> items) {
      return items.where((i) => i.isSelected == true).toList();
    }

    final _selectedItems = _filterSelected(store.state.items);

    _onAddItem(Item item) {
      store.dispatch(AddItemAction(item));
    }

    _onSelectItem(Item item, bool value) {
      store.dispatch(SelectItemAction(item, value));
    }

    _onSelectAll(bool value) {
      store.dispatch(SelectItemsAction(value));
    }

    _onDelete() {
      store.dispatch(RemoveItemsAction(_selectedItems));
    }

    _onMove(LearnState newState) {
      store.dispatch(MoveItemsAction(_selectedItems, newState));
    }

    _filterByState(List<Item> items, LearnState state) {
      return items.where((i) => i.state == state).toList();
    }

    return ViewModel(
      items: store.state.items,
      selectionCount: _selectedItems.length,
      selectionMode: _selectedItems.length > 0,
      learnedItems: _filterByState(store.state.items, LearnState.Learned),
      learningItems: _filterByState(store.state.items, LearnState.Learning),
      toLearnItems: _filterByState(store.state.items, LearnState.ToLearn),
      onAddItem: _onAddItem,
      onDelete: _onDelete,
      onMove: _onMove,
      selectItem: _onSelectItem,
      selectAll: _onSelectAll,
    );
  }
}
