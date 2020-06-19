import 'package:learningwords/models/sort_mode.dart';
import 'package:learningwords/models/word.dart';

class SelectWordAction {
  final Word item;
  final bool value;

  SelectWordAction(this.item, this.value);
}

class SelectWordsAction {
  final bool value;

  SelectWordsAction(this.value);
}

class LoadingWordsAction {}

class LoadedWordsAction {
  final List<Word> items;

  LoadedWordsAction(this.items);
}

class SortModeAction {
  final SortMode sortMode;

  SortModeAction(this.sortMode);
}