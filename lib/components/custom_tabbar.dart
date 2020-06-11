import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  const CustomTabBar({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TabBar(
        controller: controller,
        tabs: [
          const Tab(text: "習った"),
          const Tab(text: "習っている"),
          const Tab(text: "習らう"),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}