import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/components/custom_appbar.dart';
import 'package:learningwords/components/custom_drawer.dart';
import 'package:learningwords/components/dialogs.dart';
import 'package:learningwords/components/items/items_tab.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/view_model.dart';
import 'package:learningwords/search.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // TODO: ricordati che dopo 30 giorni bisogna sistemare firebase

  // TODO: errore id, su firebase hanno id diversi sull'app uguali?
  // TODO: limite elementi da cancellare -> batch?
  // TODO: sistemare meglio firebase

  // TODO: i settings su prefs

  // TODO: furigana
  // TODO: select all from the current tab ??
  // TODO: gestire le tabs con redux???
  // TODO: ricerca
  // TODO: provare a cambiare i list_item
  // TODO: tema scuro: blu-nerissimo e teal e bianco (https://dribbble.com/shots/9150888-Project-Management-App-Concept-2/attachments/1197627?mode=media)
  // TODO: https://pub.dev/packages/swipeable_card (per le review)
  // TODO: https://pub.dev/packages/fluro ??
  // TODO: sorting con bottomsheet -> vedi google drive

  Future<bool> _onBack(ViewModel model) {
    if (model.selectionMode) {
      model.selectAll(false);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onMove(ViewModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StateDialog(
          onConfirm: (state, index) {
            if (state != null) {
              model.onMove(state); // await
              _controller.animateTo(index);
            }
          },
        );
      },
    );
  }

  void _onDelete(ViewModel model) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteDialog(
          onConfirm: () {
            model.onDelete();
          },
        );
      },
    );
  }

  ScrollPhysics _physics(bool selectionMode) {
    if (selectionMode) {
      return NeverScrollableScrollPhysics();
    }
    return const PageScrollPhysics().applyTo(const BouncingScrollPhysics());
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
              drawer: CustomDrawer(),
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, _) {
                  return <Widget>[
                    CustomAppBar(
                      tabController: _controller,
                      selectionMode: vm.selectionMode,
                      selectionCount: vm.selectionCount,
                      onSelectAll: () => vm.selectAll(true),
                      onClearSelection: () => vm.selectAll(false),
                      onDelete: () => _onDelete(vm),
                      onMove: () => _onMove(vm),
                      onSearch: () {
                        showSearch(
                          context: context,
                          delegate: DataSearch(vm.items),
                        );
                      },
                    )
                  ];
                },
                body: TabBarView(
                  controller: _controller,
                  physics: _physics(vm.selectionMode),
                  children: [
                    ItemsTab(
                      model: vm,
                      items: vm.toLearnItems,
                      color: Colors.green[400],
                    ),
                    ItemsTab(
                      model: vm,
                      items: vm.learningItems,
                      color: Colors.amber[400],
                    ),
                    ItemsTab(
                      model: vm,
                      items: vm.learnedItems,
                      color: Colors.blue[400],
                    ),
                  ],
                ),
              ),
              floatingActionButton: vm.selectionMode
                  ? null
                  : FloatingActionButton.extended(
                      icon: Icon(Icons.add),
                      label: Text("Insert"),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      onPressed: () {
                        vm.selectAll(false);
                        Navigator.pushNamed(
                          context,
                          "/add",
                          arguments: {"onAddItem": vm.onAddItem},
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
