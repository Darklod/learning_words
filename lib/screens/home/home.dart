import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/screens/home/widgets/custom_appbar.dart';
import 'package:learningwords/screens/home/widgets/custom_fab.dart';
import 'package:learningwords/search.dart';
import 'package:learningwords/viewmodels/home_viewmodel.dart';
import 'package:learningwords/widgets/custom_drawer.dart';
import 'package:learningwords/widgets/dialogs/choice_dialog.dart';
import 'package:learningwords/widgets/dialogs/delete_dialog.dart';
import 'package:learningwords/widgets/error_notifier.dart';
import 'package:learningwords/widgets/words/words_tab.dart';
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

  // TODO: select all from the current tab ??
  // TODO: gestire le tabs con redux???

  // TODO: i settings su prefs

  // TODO: furigana
  // TODO: sorting con bottomsheet -> vedi google drive

  // TODO: ricerca
  // TODO: provare a cambiare i list_item

  // TODO: tema scuro: blu-nero e teal e bianco (https://dribbble.com/shots/9150888-Project-Management-App-Concept-2/attachments/1197627?mode=media)

  // TODO: https://pub.dev/packages/swipeable_card (per le review)
  // TODO: https://pub.dev/packages/fluro ??

  Future<bool> _onBack(HomeViewModel model) {
    if (model.selectionMode) {
      model.selectAll(false);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onMove(HomeViewModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChoiceDialog(
          title: "Select State",
          choices: ["To Learn", "Learning", "Learned"],
          onCancel: () {
            Navigator.pop(context);
          },
          onConfirm: (state, index) {
            if (state != null) {
              model.onMove(state);
              _controller.animateTo(index);
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _onDelete(HomeViewModel model) {
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
    return StoreConnector<AppState, HomeViewModel>(
      converter: (Store<AppState> store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel vm) {
        return WillPopScope(
          onWillPop: () => _onBack(vm),
          child: Scaffold(
            drawer: CustomDrawer(),
            body: ErrorNotifier(
              child: NestedScrollView(
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
                          delegate: DataSearch(vm.words),
                        );
                      },
                    )
                  ];
                },
                body: TabBarView(
                  controller: _controller,
                  physics: _physics(vm.selectionMode),
                  children: [
                    WordsTab(
                      selectionMode: vm.selectionMode,
                      selectItem: vm.selectWord,
                      items: vm.toLearnWords,
                      sortMode: vm.sortMode,
                      color: Colors.green[400],
                    ),
                    WordsTab(
                      selectionMode: vm.selectionMode,
                      selectItem: vm.selectWord,
                      items: vm.learningWords,
                      sortMode: vm.sortMode,
                      color: Colors.amber[400],
                    ),
                    WordsTab(
                      selectionMode: vm.selectionMode,
                      selectItem: vm.selectWord,
                      items: vm.learnedWords,
                      sortMode: vm.sortMode,
                      color: Colors.blue[400],
                    ),
                  ],
                ),
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
        );
      },
    );
  }
}
