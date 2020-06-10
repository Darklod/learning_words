import 'package:flutter/material.dart';
import 'package:learningwords/components/invisible_appbar.dart';
import 'package:learningwords/components/level/level.dart';
import 'package:learningwords/components/level/level_field.dart';
import 'package:learningwords/components/scrollable_footer.dart';
import 'package:learningwords/components/section_field.dart';
import 'package:learningwords/models/item.dart';

class AddPage extends StatefulWidget {
  final Function(Item) onAddItem;

  const AddPage({Key key, this.onAddItem}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  var _item = Item.empty();

  _onSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      widget.onAddItem(_item); // await when firebase
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              InvisibleAppBar(title: "Add Word"),
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
                                () => _item = _item.copyWith(translation: s));
                          },
                        ),
                        CustomSectionField(
                          title: "Level",
                          spacing: 16.0,
                          padding: EdgeInsets.zero,
                          child: LevelField(
                            selected: 0,
                            levels: [
                              Level(text: "To Learn", color: Colors.green[300]),
                              Level(text: "Learning", color: Colors.amber[400]),
                              Level(text: "Learned", color: Colors.blue[400]),
                            ],
                            onChange: (index) {
                              LearnState state;
                              switch (index) {
                                case 2:
                                  state = LearnState.Learned;
                                  break;
                                case 1:
                                  state = LearnState.Learning;
                                  break;
                                case 0:
                                default:
                                  state = LearnState.ToLearn;
                                  break;
                              }

                              setState(
                                  () => _item = _item.copyWith(state: state));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(24.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0,
                  ),
                  child: Text("ADD", style: TextStyle(color: Colors.white)),
                  color: Colors.teal,
                  onPressed: _onSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
