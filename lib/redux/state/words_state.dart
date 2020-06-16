import 'package:flutter/foundation.dart';
import 'package:learningwords/models/word.dart';

@immutable
class WordsState {
  final List<Word> words;
  final String sortMode;

  const WordsState({@required this.words, @required this.sortMode});

  WordsState.initial()
      : words = List.unmodifiable(<Word>[]),
        sortMode = "Date";

  WordsState copyWith({List<Word> words, String sortMode}) {
    return WordsState(
      words: words ?? this.words,
      sortMode: sortMode ?? this.sortMode,
    );
  }

  Map toJson() => null;

  factory WordsState.fromJson(Map json) {
    return WordsState.initial();
  }
}
