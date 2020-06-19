import 'package:learningwords/models/sort_mode.dart';
import 'package:learningwords/models/word.dart';
import 'package:learningwords/redux/actions/words_actions.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/redux/thunk/words_middlewares.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  final List<Word> words;
  final List<Word> learnedWords;
  final List<Word> toLearnWords;
  final List<Word> learningWords;
  final SortMode sortMode;
  final Function() onDelete;
  final Function(String) onMove;
  final Function(Word, bool) selectWord;
  final Function(bool) selectAll;
  final int selectionCount;
  final bool selectionMode;

  HomeViewModel({
    this.words,
    this.selectionMode,
    this.selectionCount,
    this.learnedWords,
    this.toLearnWords,
    this.learningWords,
    this.sortMode,
    this.onDelete,
    this.onMove,
    this.selectWord,
    this.selectAll,
  });

  factory HomeViewModel.create(Store<AppState> store) {
    final sortMode = store.state.words.sortMode;
    final words = store.state.words.words;

    _filterSelected(List<Word> items) {
      return items.where((i) => i.isSelected == true).toList();
    }

    final _selectedItems = _filterSelected(words);

    _compare(Word a, Word b) {
      final m = sortMode.mode == "ASC" ? 1 : -1;

      switch (sortMode.field) {
        case "Kana":
          return a.kana.compareTo(b.kana) * m;
        case "Translation":
          return a.translation.compareTo(b.translation) * m;
        case "JLPT":
          return a.jlpt.compareTo(b.jlpt) * m;
        case "Date":
          return a.timestamp.compareTo(b.timestamp) * m;
        default:
          return a.id.compareTo(b.id) * m;
      }
    }

    _onDelete() {
      store.dispatch(deleteWords(_selectedItems));
    }

    _onMove(String newState) {
      store.dispatch(moveWords(_selectedItems, newState));
    }

    _onSelectItem(Word item, bool value) {
      store.dispatch(SelectWordAction(item, value));
    }

    _onSelectAll(bool value) {
      store.dispatch(SelectWordsAction(value));
    }

    _filterByState(List<Word> items, String state) {
      return items.where((i) => i.state == state).toList();
    }

    return HomeViewModel(
      words: words,
      sortMode: sortMode,
      selectionCount: _selectedItems.length,
      selectionMode: _selectedItems.length > 0,
      learnedWords: _filterByState(words, "Learned")..sort(_compare),
      learningWords: _filterByState(words, "Learning")..sort(_compare),
      toLearnWords: _filterByState(words, "To Learn")..sort(_compare),
      onDelete: _onDelete,
      onMove: _onMove,
      selectWord: _onSelectItem,
      selectAll: _onSelectAll,
    );
  }
}
