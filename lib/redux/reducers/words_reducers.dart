import 'package:learningwords/redux/actions/words_actions.dart';
import 'package:learningwords/redux/state/words_state.dart';
import 'package:redux/redux.dart';

Reducer<WordsState> wordsReducer = combineReducers<WordsState>([
  TypedReducer<WordsState, LoadedWordsAction>(_loadItemsReducer),
  TypedReducer<WordsState, SelectWordAction>(_selectItemReducer),
  TypedReducer<WordsState, SelectWordsAction>(_selectItemsReducer),
  TypedReducer<WordsState, SortModeAction>(_changeSortMode),
]);

WordsState _loadItemsReducer(WordsState state, LoadedWordsAction action) {
  return state.copyWith(words: action.items);
}

WordsState _selectItemReducer(WordsState state, SelectWordAction action) {
  final words = state.words
      .map((item) => item.id == action.item.id
          ? item.copyWith(isSelected: action.value)
          : item)
      .toList();

  return state.copyWith(words: words);
}

WordsState _selectItemsReducer(WordsState state, SelectWordsAction action) {
  final words = state.words
      .map((item) => item.copyWith(isSelected: action.value))
      .toList();

  return state.copyWith(words: words);
}

WordsState _changeSortMode(WordsState state, SortModeAction action) {
  return state.copyWith(sortMode: action.sortMode);
}
