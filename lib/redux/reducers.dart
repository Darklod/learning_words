import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
    selectionMode: false,
  );
}

List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    return []
      ..addAll(state)
      ..add(action.item);
  }

  if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if (action is RemoveItemsAction) {
    return List.unmodifiable(List.from(state)..remove(action.items));
  }

  if (action is LoadedItemsAction) {
    return action.items;
  }

  // TEMP
  if (action is GetItemsAction) {
    return <Item>[
      Item(kanji: "希望", kana: "", translation: "Hope", state: LearnState.Learning),
      Item(kanji: "絶望", kana: "", translation: "Despair", state: LearnState.Learning),
      Item(kanji: "未来", kana: "", translation: "Future", state: LearnState.Learned),
      Item(kanji: "駅", kana: "", translation: "Station", state: LearnState.Learned),
      Item(kanji: "市場", kana: "", translation: "Market", state: LearnState.ToLearn),
      Item(kanji: "犬", kana: "", translation: "Dog", state: LearnState.Learned),
      Item(kanji: "猫", kana: "", translation: "Cat", state: LearnState.Learned),
      Item(kanji: "混乱", kana: "", translation: "Confusion", state: LearnState.Learning),
      Item(kanji: "血", kana: "", translation: "Blood", state: LearnState.ToLearn),
    ];
  }

  return state;
}
