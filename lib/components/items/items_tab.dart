import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/components/items/item_list.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/middlewares/item.dart';
import 'package:redux/redux.dart';

class ItemsTab extends StatelessWidget {
  final List<Item> items;
  final Color color;
  final bool selectionMode;
  final Function(Item, bool) selectItem;

  ItemsTab({this.items, this.color, this.selectionMode = false, this.selectItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector(
        converter: (Store<AppState> store) => store,
        builder: (BuildContext context, Store vm) {
          return RefreshIndicator(
            onRefresh: () async => await vm.dispatch(getItems()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          items.length.toString(),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_downward, size: 18),
                            Text(
                              "名前",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16.0).copyWith(bottom: 0),
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
