import 'package:flutter/material.dart';

enum LearnState { Learned, Learning, ToLearn }

class _LearnStateHelper {
  static LearnState from(String name) {
    switch (name) {
      case 'Learned':
        return LearnState.Learned;
      case 'Learning':
        return LearnState.Learning;
      case 'ToLearn':
      default:
        return LearnState.ToLearn;
    }
  }
}

class Item {
  final String id;
  final String kanji;
  final String kana;
  final String translation;
  final LearnState state;
  final bool isSelected;

  const Item({
    @required this.id,
    @required this.kanji,
    @required this.kana,
    @required this.translation,
    @required this.state,
    this.isSelected = false,
  });

  Item.empty()
      : id = "",
        kanji = "",
        kana = "",
        state = LearnState.ToLearn,
        translation = "",
        isSelected = false;

  Item copyWith({
    String kanji,
    String kana,
    String translation,
    LearnState state,
    bool isSelected,
  }) {
    return Item(
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
      kana: kana ?? this.kana,
      translation: translation ?? this.translation,
      state: state ?? this.state,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory Item.fromJson(Map json) {
    return Item(
      id: json["id"] ?? "",
      kanji: json["kanji"] ?? "",
      kana: json["kana"] ?? "",
      translation: json["translation"] ?? "",
      state: _LearnStateHelper.from(json["state"]),
    );
  }

  Map toJson() {
    return {
      "id": id,
      "kanji": kanji,
      "kana": kana,
      "translation": translation,
      "state": state.toString(),
    };
  }
}
