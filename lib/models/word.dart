import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Word {
  final String id;
  final String kanji;
  final String kana;
  final String translation;
  final String jlpt;
  final String state;
  final int timestamp;
  final bool isSelected;

  const Word({
    @required this.id,
    @required this.kanji,
    @required this.kana,
    @required this.translation,
    @required this.jlpt,
    @required this.state,
    this.timestamp = 0,
    this.isSelected = false,
  });

  Word.empty()
      : id = "",
        kanji = "",
        kana = "",
        state = "To Learn",
        jlpt = "none",
        translation = "",
        timestamp = 0,
        isSelected = false;

  Word copyWith({
    String kanji,
    String kana,
    String translation,
    String state,
    String jlpt,
    int timestamp,
    bool isSelected,
  }) {
    return Word(
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
      kana: kana ?? this.kana,
      translation: translation ?? this.translation,
      jlpt: jlpt ?? this.jlpt,
      state: state ?? this.state,
      timestamp: timestamp ?? this.timestamp,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory Word.fromJson(Map json) {
    return Word(
      id: json["id"] ?? "",
      kanji: json["kanji"] ?? "",
      kana: json["kana"] ?? "",
      translation: json["translation"] ?? "",
      state: json["state"] ?? "",
      timestamp: json["timestamp"] ?? 0,
      jlpt: json["jlpt"] ?? "",
    );
  }

  factory Word.fromSnapshot(DocumentSnapshot snapshot) {
    return Word.fromJson(snapshot.data);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kanji": kanji,
      "kana": kana,
      "translation": translation,
      "jlpt": jlpt,
      "state": state,
      "timestamp": timestamp,
    };
  }
}
