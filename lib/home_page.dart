import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/add_page.dart';
import 'package:learningwords/data_search.dart';
import 'package:learningwords/models/item.dart';
import 'package:learningwords/models/models.dart';
import 'package:learningwords/redux/actions.dart';
import 'package:learningwords/word_list.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _list = [
    {"kanji": "希望", "trad": "Hope"},
    {"kanji": "絶望", "trad": "Despair"},
    {"kanji": "未来", "trad": "Future"},
    {"kanji": "駅", "trad": "Station"},
    {"kanji": "市場", "trad": "Market"},
    {"kanji": "日記", "trad": "Diary"},
    {"kanji": "犬", "trad": "Dog"},
    {"kanji": "猫", "trad": "Cat"},
    {"kanji": "混乱", "trad": "Confusion"},
    {"kanji": "血", "trad": "Blood"},
  ]..shuffle();

  var _selectedItems = [];

  get _selectionMode => _selectedItems.length > 0;

  bool _onSelectItem(index) {
    if (!_selectedItems.contains(index)) {
      setState(() => _selectedItems.add(index));
      print(_selectedItems);
      return true;
    } else {
      setState(() {
        _selectedItems.remove(index);
      });
      print(_selectedItems);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_selectionMode) {
          setState(() {
            _selectedItems.clear();
          });
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(),
          body: StoreConnector<AppState, _ViewModel>(
            converter: (Store<AppState> store) => _ViewModel.create(store),
            builder: (context, _ViewModel viewModel) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      title: Text(
                        _selectionMode ? "${_selectedItems.length}" : "Words",
                      ),
                      centerTitle: !_selectionMode,
                      floating: !_selectionMode,
                      pinned: true,
                      snap: !_selectionMode,
                      backgroundColor:
                          !_selectionMode ? Colors.teal : Colors.blue,
                      actions: _selectionMode
                          ? [
                              IconButton(
                                icon: Icon(Icons.done_all),
                                tooltip: "Select All",
                                onPressed: () {
                                  setState(() {
                                    _selectedItems.clear();
                                    _selectedItems = List<int>.generate(
                                      _list.length,
                                      (i) => i + 1,
                                    );
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.move_to_inbox),
                                tooltip: "Move",
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                tooltip: "Delete",
                                onPressed: () {},
                              ),
                            ]
                          : [
                              IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  showSearch(
                                    context: context,
                                    delegate: DataSearch(),
                                  );
                                },
                              ),
                            ],
                      leading: _selectionMode
                          ? IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  _selectedItems.clear();
                                });
                              },
                            )
                          : null,
                      bottom: buildTabBar(context),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    WordList(
                      _list,
                      Colors.blue[400],
                      _selectedItems.length > 0,
                      _onSelectItem,
                    ),
                    WordList(
                      _list,
                      Colors.amber[300],
                      _selectedItems.length > 0,
                      _onSelectItem,
                    ),
                    WordList(
                      _list,
                      Colors.green[300],
                      _selectedItems.length > 0,
                      _onSelectItem,
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddPage()));
            },
          ),
        ),
      ),
    );
  }

  Widget buildTabBar(context) {
    return const PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TabBar(
          tabs: [
            Tab(text: "習った"),
            Tab(text: "習っている"),
            Tab(text: "習らう"),
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<Item> items;
  final Function(Item) onAddItem;
  final Function(Item) onRemoveItem;
  final Function(List<Item>) onRemoveItems;

  _ViewModel({
    this.items,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveItems,
  });

  factory _ViewModel.create(Store<AppState> store) {
    _onAddItem(Item item) {
      store.dispatch(AddItemAction(item));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems(List<Item> item) {
      store.dispatch(RemoveItemsAction(item));
    }

    return _ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
    );
  }
}
