import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/models/word.dart';
import 'package:learningwords/redux/actions/words_actions.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/redux/thunk/words_middlewares.dart';
import 'package:learningwords/widgets/dialogs/choice_dialog.dart';
import 'package:learningwords/widgets/words/word_list.dart';
import 'package:redux/redux.dart';

class WordsTab extends StatelessWidget {
  final List<Word> items;
  final Color color;
  final bool selectionMode;
  final String sortMode;
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
    return Container(
      child: StoreConnector(
        converter: (Store<AppState> store) => store,
        builder: (BuildContext context, Store vm) {
          return RefreshIndicator(
            onRefresh: () async => await vm.dispatch(getWords()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          items.length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ChoiceDialog(
                                  choices: [
                                    "Kana",
                                    "Translation",
                                    "JLPT",
                                    "Date"
                                  ],
                                  title: "Sort by",
                                  onCancel: () => Navigator.pop(context),
                                  onConfirm: (choice, _) {
                                    vm.dispatch(SortModeAction(choice));
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward, size: 18),
                              Text(
                                sortMode,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20.0).copyWith(bottom: 0),
                  ),
                  WordList(items, color, selectionMode, selectItem),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
