import 'package:flutter/material.dart';
import 'package:learningwords/components/invisible_appbar.dart';
import 'package:learningwords/components/level/level.dart';
import 'package:learningwords/components/level/level_field.dart';
import 'package:learningwords/components/scrollable_footer.dart';
import 'package:learningwords/components/section_field.dart';

class AddPage extends StatelessWidget {
  _onPressed() {}

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
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  child: Column(
                    children: [
                      TextSectionField(title: "Kanji", hint: "漢字"),
                      TextSectionField(title: "Kana", hint: "かな"),
                      TextSectionField(title: "Translation", hint: "訳"),
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
                          onChange: (index) {},
                        ),
                      ),
                    ],
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
                  onPressed: _onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
