import 'package:flutter/foundation.dart';

enum LearnState { Learned, Learning, ToLearn }

class _LearnStateHelper {
  static LearnState from(String name) {
    switch (name) {
      case 'Learned':
        return LearnState.Learned;
      case 'Learning':
        return LearnState.Learning;
      case 'ToLearn':
        return LearnState.ToLearn;
      default:
        throw RangeError("enum Fruit contains no value '$name'");
    }
  }
}

class Item {
  final String kanji;
  final String kana;
  final String translation;
  final LearnState state;

  const Item({
    @required this.kanji,
    @required this.kana,
    @required this.translation,
    @required this.state,
  });

  Item.fromJson(Map json)
      : kanji = json["kanji"],
        kana = json["kana"],
        translation = json["translation"],
        state = _LearnStateHelper.from(json["state"]);

  Map toJson() {
    return {
      "kanji": kanji,
      "kana": kana,
      "translation": translation,
      "state": state.toString(),
    };
  }
}
