import 'package:flutter/material.dart';
import 'package:learningwords/pages/add.dart';
import 'package:learningwords/pages/home.dart';

const String homeRoute = '/';
const String addRoute = '/add';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case addRoute:
        var data = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => AddPage(onAddItem: data["onAddItem"]),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
