import 'package:flutter/material.dart';

class Item {
  final String id;
  final String kanji;
  final String kana;
  final String translation;
  final String jlpt;
  final String state;
  final bool isSelected;

  const Item({
    @required this.id,
    @required this.kanji,
    @required this.kana,
    @required this.translation,
    @required this.jlpt,
    @required this.state,
    this.isSelected = false,
  });

  Item.empty()
      : id = "",
        kanji = "",
        kana = "",
        state = "To Learn",
        jlpt = "none",
        translation = "",
        isSelected = false;

  Item copyWith({
    String kanji,
    String kana,
    String translation,
    String state,
    String jlpt,
    bool isSelected,
  }) {
    return Item(
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
      kana: kana ?? this.kana,
      translation: translation ?? this.translation,
      jlpt: jlpt ?? this.jlpt,
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
      state: json["state"] ?? "",
      jlpt: json["jlpt"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kanji": kanji,
      "kana": kana,
      "translation": translation,
      "jlpt": jlpt,
      "state": state,
    };
  }
}
