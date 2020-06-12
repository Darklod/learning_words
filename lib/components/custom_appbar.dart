import 'package:flutter/material.dart';
import 'package:learningwords/components/custom_tabbar.dart';

class CustomAppBar extends StatelessWidget {
  final bool selectionMode;
  final int selectionCount;
  final Function onSearch;
  final Function onSelectAll;
  final Function onDelete;
  final Function onMove;
  final Function onClearSelection;
  final TabController tabController;

  const CustomAppBar({
    @required this.tabController,
    @required this.selectionMode,
    @required this.selectionCount,
    @required this.onSearch,
    @required this.onSelectAll,
    @required this.onDelete,
    @required this.onMove,
    @required this.onClearSelection,
  });

  List<Widget> get _actions {
    return [
      IconButton(
        icon: Icon(Icons.search),
        tooltip: "Search",
        onPressed: onSearch,
      ),
    ];
  }

  List<Widget> get _selectionActions {
    return [
      IconButton(
        icon: Icon(Icons.move_to_inbox),
        tooltip: "Move",
        onPressed: onMove,
      ),
      IconButton(
        icon: Icon(Icons.select_all),
        tooltip: "Select All",
        onPressed: onSelectAll,
      ),
      IconButton(
        icon: Icon(Icons.delete),
        tooltip: "Delete",
        onPressed: onDelete,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(selectionMode ? "$selectionCount selected" : "Words"),
      backgroundColor: !selectionMode
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      //Color(0xFF363640),
      centerTitle: !selectionMode,
      floating: !selectionMode,
      snap: !selectionMode,
      pinned: true,
      forceElevated: true,
      actions: selectionMode ? _selectionActions : _actions,
      leading: selectionMode
          ? IconButton(
              icon: Icon(Icons.close),
              tooltip: "Clear",
              onPressed: onClearSelection,
            )
          : null,
      bottom: CustomTabBar(controller: tabController),
    );
  }
}
