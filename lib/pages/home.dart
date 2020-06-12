import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/components/custom_appbar.dart';
import 'package:learningwords/components/custom_drawer.dart';
import 'package:learningwords/components/dialogs.dart';
import 'package:learningwords/components/items/item_list.dart';
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

  // TODO: gestire meglio l'ordine delle tab nei vari file
  // TODO: select all from the current tab ??
  // TODO: gestire le tabs con redux???
  // TODO: aggiungere il numero di elementi !!!
  // TODO: switch light/dark theme
  // TODO: ricerca
  // TODO: provare a cambiare i list_item
  // TODO: tema scuro: blu-nerissimo e teal e bianco (https://dribbble.com/shots/9150888-Project-Management-App-Concept-2/attachments/1197627?mode=media)
  // TODO: https://pub.dev/packages/swipeable_card (per le review)
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
                      onSearch: () => showSearch(
                        context: context,
                        delegate: DataSearch(vm.items),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _controller,
                  physics: _physics(vm.selectionMode),
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(vm.learnedItems.length.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_downward, size: 18),
                                    Text(
                                      "名前",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(16.0).copyWith(bottom: 0),
                          ),
                          WordList(
                            vm,
                            vm.learnedItems,
                            Colors.blue[400],
                          ),
                        ],
                      ),
                    ),
                    WordList(vm, vm.learningItems, Colors.amber[300]),
                    WordList(vm, vm.toLearnItems, Colors.green[300]),
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
