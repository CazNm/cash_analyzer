// import 'package:cash_analyzer/screens/detail/detailView.dart';
import 'package:cash_analyzer/screens/main/mainListView.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainListViewHome());

      // 404 not found lol
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
