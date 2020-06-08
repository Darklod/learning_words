import 'package:learningwords/models/item.dart';

class AddItemAction {
  final Item item;

  AddItemAction(this.item);
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
}

class RemoveItemsAction {
  final List<Item> items;

  RemoveItemsAction(this.items);
}

class SelectItemAction {
  final Item item;
  final bool value;

  SelectItemAction(this.item, this.value);
}

class SelectItemsAction {
  final bool value;

  SelectItemsAction(this.value);
}

class GetItemsAction {}

class LoadedItemsAction {
  final List<Item> items;

  LoadedItemsAction(this.items);
}
