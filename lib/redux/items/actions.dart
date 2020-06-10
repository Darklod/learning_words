import 'package:learningwords/models/item.dart';

// Insert
class AddItemAction {
  final Item item;

  AddItemAction(this.item);
}

// Delete
class RemoveItemsAction {
  final List<Item> items;

  RemoveItemsAction(this.items);
}

// Move
class MoveItemsAction {
  final List<Item> items;
  final LearnState newState;

  MoveItemsAction(this.items, this.newState);
}

// Select
class SelectItemAction {
  final Item item;
  final bool value;

  SelectItemAction(this.item, this.value);
}

// MultiSelect
class SelectItemsAction {
  final bool value;

  SelectItemsAction(this.value);
}

// Get
class GetItemsAction {}

// Load
class LoadedItemsAction {
  final List<Item> items;

  LoadedItemsAction(this.items);
}
