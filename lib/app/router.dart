import 'package:cash_analyzer/mainList/mainListView.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainListViewHome());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
