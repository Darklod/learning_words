import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/components/custom_appbar.dart';
import 'package:learningwords/components/custom_drawer.dart';
import 'package:learningwords/components/dialogs.dart';
import 'package:learningwords/components/home/custom_fab.dart';
import 'package:learningwords/components/items/items_tab.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/redux/actions/item.dart';
import 'package:learningwords/redux/middlewares/item.dart';
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

  Future<bool> _onBack(_ViewModel model) {
    if (model.selectionMode) {
      model.selectAll(false);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onMove(_ViewModel model) {
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

  void _onDelete(_ViewModel model) {
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
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel vm) {
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
                      selectionMode: vm.selectionMode,
                      selectItem: vm.selectItem,
                      items: vm.toLearnItems,
                      color: Colors.green[400],
                    ),
                    ItemsTab(
                      selectionMode: vm.selectionMode,
                      selectItem: vm.selectItem,
                      items: vm.learningItems,
                      color: Colors.amber[400],
                    ),
                    ItemsTab(
                      selectionMode: vm.selectionMode,
                      selectItem: vm.selectItem,
                      items: vm.learnedItems,
                      color: Colors.blue[400],
                    ),
                  ],
                ),
              ),
              floatingActionButton: CustomFAB(
                selectionMode: vm.selectionMode,
                onPressed: () {
                  vm.selectAll(false);
                  Navigator.pushNamed(context, "/add");
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List<Item> items;
  final List<Item> learnedItems;
  final List<Item> toLearnItems;
  final List<Item> learningItems;
  final Function() onDelete;
  final Function(String) onMove;
  final Function(Item, bool) selectItem;
  final Function(bool) selectAll;
  final int selectionCount;
  final bool selectionMode;

  _ViewModel({
    this.items, // Search, Home
    this.selectionMode, // Home, Item
    this.selectionCount, // Home
    this.learnedItems, // Home
    this.toLearnItems, // Home
    this.learningItems, // Home
    this.onDelete, // Home
    this.onMove, // Home
    this.selectItem, // Item
    this.selectAll, // Home
  });

  factory _ViewModel.create(Store<AppState> store) {
    _filterSelected(List<Item> items) {
      return items.where((i) => i.isSelected == true).toList();
    }

    final _selectedItems = _filterSelected(store.state.items);

    _onDelete() {
      store.dispatch(deleteItems(_selectedItems));
    }

    _onMove(String newState) {
      store.dispatch(moveItems(_selectedItems, newState));
    }

    _onSelectItem(Item item, bool value) {
      store.dispatch(SelectItemAction(item, value));
    }

    _onSelectAll(bool value) {
      store.dispatch(SelectItemsAction(value));
    }

    _filterByState(List<Item> items, String state) {
      return items.where((i) => i.state == state).toList();
    }

    return _ViewModel(
      items: store.state.items,
      selectionCount: _selectedItems.length,
      selectionMode: _selectedItems.length > 0,
      learnedItems: _filterByState(store.state.items, "Learned"),
      learningItems: _filterByState(store.state.items, "Learning"),
      toLearnItems: _filterByState(store.state.items, "To Learn"),
      onDelete: _onDelete,
      onMove: _onMove,
      selectItem: _onSelectItem,
      selectAll: _onSelectAll,
    );
  }
}
