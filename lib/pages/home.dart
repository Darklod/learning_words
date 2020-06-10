import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/components/custom_appbar.dart';
import 'package:learningwords/components/items/item_list.dart';
import 'package:learningwords/components/state_dialog.dart';
import 'package:learningwords/data_search.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/pages/add.dart';
import 'package:learningwords/redux/view_model.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Future<bool> _onBack(ViewModel model) {
    if (model.selectionMode) {
      model.selectAll(false);
      return Future.value(false);
    }
    return Future.value(true);
  }

  _onMove(ViewModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StateDialog(
          onConfirm: (state) {
            if (state != null) model.onMove(state); // await
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel vm) {
        return WillPopScope(
          onWillPop: () => _onBack(vm),
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              drawer: Drawer(),
              body: NestedScrollView(
                headerSliverBuilder: (_, bool innerBoxIsScrolled) {
                  return <Widget>[
                    CustomAppBar(
                      selectionMode: vm.selectionMode,
                      selectionCount: vm.selectionCount,
                      onSelectAll: () => vm.selectAll(true),
                      onClearSelection: () => vm.selectAll(false),
                      onDelete: () => vm.onDelete(),
                      onMove: () => _onMove(vm),
                      onSearch: () => showSearch(
                        context: context,
                        delegate: DataSearch(),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: [
                    WordList(vm, vm.learnedItems, Colors.blue[400]),
                    WordList(vm, vm.learningItems, Colors.amber[300]),
                    WordList(vm, vm.toLearnItems, Colors.green[300]),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  vm.selectAll(false);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddPage(onAddItem: vm.onAddItem),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
