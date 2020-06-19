import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/models/sort_mode.dart';
import 'package:learningwords/models/word.dart';
import 'package:learningwords/redux/actions/words_actions.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/redux/thunk/words_middlewares.dart';
import 'package:learningwords/widgets/dialogs/sort_dialog.dart';
import 'package:learningwords/widgets/words/word_list.dart';
import 'package:redux/redux.dart';

class WordsTab extends StatelessWidget {
  final List<Word> items;
  final Color color;
  final bool selectionMode;
  final SortMode sortMode;
  final Function(Word, bool) selectItem;

  WordsTab({
    this.items,
    this.color,
    this.selectionMode = false,
    this.selectItem,
    this.sortMode,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => store,
      builder: (BuildContext context, Store vm) {
        return RefreshIndicator(
          onRefresh: () async => await vm.dispatch(getWords()),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkResponse(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SortDialog(
                                  choices: [
                                    "Kana",
                                    "Translation",
                                    "JLPT",
                                    "Date"
                                  ],
                                  initialChoice: sortMode.field,
                                  mode: sortMode.mode,
                                  title: "Sort By",
                                  onCancel: () => Navigator.pop(context),
                                  onConfirm: (String choice, String mode) {
                                    vm.dispatch(SortModeAction(
                                      SortMode(mode, choice),
                                    ));
                                    // TODO: wait for a second and pop
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                          containedInkWell: false,
                          radius: 50,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  sortMode.field,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Icon(
                                  sortMode.mode == "ASC"
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          items.length.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8.0).copyWith(bottom: 0, right: 24),
                  ),
                  WordList(items, color, selectionMode, selectItem),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
