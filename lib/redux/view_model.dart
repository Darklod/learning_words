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
  final Function(Item) onRemoveItem;
  final Function(List<Item>) onRemoveItems;
  final Function(Item, bool) selectItem;
  final Function(bool) selectAll;
  final int selectionCount;
  final bool selectionMode;

  ViewModel({
    this.items,
    this.selectionMode,
    this.selectionCount,
    this.learnedItems,
    this.toLearnItems,
    this.learningItems,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveItems,
    this.selectItem,
    this.selectAll,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onAddItem(Item item) {
      store.dispatch(AddItemAction(item));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems(List<Item> item) {
      store.dispatch(RemoveItemsAction(item));
    }

    _onSelectItem(Item item, bool value) {
      store.dispatch(SelectItemAction(item, value));
    }

    _onSelectAll(bool value) {
      store.dispatch(SelectItemsAction(value));
    }

    _filterByState(List<Item> items, LearnState state) {
      return items.where((i) => i.state == state).toList();
    }

    _filterSelected(List<Item> items) {
      return items.where((i) => i.isSelected == true).toList();
    }

    final _selectedItems = _filterSelected(store.state.items);

    return ViewModel(
      items: store.state.items,
      selectionCount: _selectedItems.length,
      selectionMode: _selectedItems.length > 0,
      learnedItems: _filterByState(store.state.items, LearnState.Learned),
      learningItems: _filterByState(store.state.items, LearnState.Learning),
      toLearnItems: _filterByState(store.state.items, LearnState.ToLearn),
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
      selectItem: _onSelectItem,
      selectAll: _onSelectAll,
    );
  }
}
