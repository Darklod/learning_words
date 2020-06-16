import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/models/word.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/redux/thunk/words_middlewares.dart';
import 'package:learningwords/screens/add/widgets/invisible_appbar.dart';
import 'package:learningwords/screens/add/widgets/scrollable_footer.dart';
import 'package:learningwords/screens/add/widgets/section_field.dart';
import 'package:learningwords/widgets/level/level.dart';
import 'package:learningwords/widgets/level/level_field.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  var _item = Word.empty();

  _onSave() {
    final store = StoreProvider.of<AppState>(context);

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      store.dispatch(addWord(_item));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: ScrollableFooter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InvisibleAppBar(title: "Insert Word", onSave: _onSave),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,
                    ),
                    child: Column(
                      children: [
                        TextSectionField(
                          title: "Kanji",
                          hint: "漢字",
                          onSaved: (s) {
                            print("ciao");
                            setState(() => _item = _item.copyWith(kanji: s));
                          },
                        ),
                        TextSectionField(
                          title: "Kana",
                          hint: "かな",
                          onSaved: (s) {
                            setState(() => _item = _item.copyWith(kana: s));
                          },
                        ),
                        TextSectionField(
                          title: "Translation",
                          hint: "訳",
                          onSaved: (s) {
                            setState(
                              () => _item = _item.copyWith(translation: s),
                            );
                          },
                        ),
                        CustomSectionField(
                          title: "State",
                          spacing: 16.0,
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: LevelField(
                            selected: "To Learn",
                            levelPadding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                            levels: [
                              Level(text: "To Learn", color: Colors.green[300]),
                              Level(text: "Learning", color: Colors.amber[400]),
                              Level(text: "Learned", color: Colors.blue[400]),
                            ],
                            onChange: (String value) {
                              setState(
                                () => _item = _item.copyWith(state: value),
                              );
                            },
                          ),
                        ),
                        CustomSectionField(
                          title: "JLPT",
                          spacing: 16.0,
                          padding: EdgeInsets.zero,
                          child: LevelField(
                            selected: "None",
                            levelPadding: const EdgeInsets.all(12.0),
                            levels: [
                              Level(text: "None", color: Colors.redAccent),
                              Level(text: "N5", color: Colors.redAccent),
                              Level(text: "N4", color: Colors.redAccent),
                              Level(text: "N3", color: Colors.redAccent),
                              Level(text: "N2", color: Colors.redAccent),
                              Level(text: "N1", color: Colors.redAccent),
                            ],
                            onChange: (String value) {
                              setState(() {
                                _item = _item.copyWith(jlpt: value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
