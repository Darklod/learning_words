import 'package:flutter/material.dart';
import 'package:learningwords/add_page.dart';
import 'package:learningwords/data_search.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:learningwords/redux/view_model.dart';
import 'package:learningwords/word_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel vm) {
        return WillPopScope(
          onWillPop: () {
            if (vm.selectionMode) {
              vm.selectAll(false);
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              drawer: Drawer(),
              body: NestedScrollView(
                headerSliverBuilder: (_, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      title: Text(
                        vm.selectionMode
                            ? "${vm.selectionCount} selected"
                            : "Words",
                      ),
                      centerTitle: !vm.selectionMode,
                      floating: !vm.selectionMode,
                      pinned: true,
                      snap: !vm.selectionMode,
                      backgroundColor:
                          !vm.selectionMode ? Colors.teal : Color(0xFF363640),
                      actions: vm.selectionMode
                          ? [
                              IconButton(
                                icon: Icon(Icons.done_all),
                                tooltip: "Select All",
                                onPressed: () {
                                  vm.selectAll(true);
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
                      leading: vm.selectionMode
                          ? IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => vm.selectAll(false),
                            )
                          : null,
                      bottom: buildTabBar(context),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    WordList(vm, vm.toLearnItems, Colors.blue[400]),
                    WordList(vm, vm.learningItems, Colors.amber[300]),
                    WordList(vm, vm.learnedItems, Colors.green[300]),
                  ],
                ),
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
      },
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
