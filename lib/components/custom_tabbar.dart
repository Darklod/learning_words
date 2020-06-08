import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.all(8.0),
      child: TabBar(
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