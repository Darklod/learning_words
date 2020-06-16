import 'package:learningwords/models/item.dart';

class SelectItemAction {
  final Item item;
  final bool value;

  SelectItemAction(this.item, this.value);
}

class SelectItemsAction {
  final bool value;

  SelectItemsAction(this.value);
}

class LoadingItemsAction {}

class LoadedItemsAction {
  final List<Item> items;

  LoadedItemsAction(this.items);
}
