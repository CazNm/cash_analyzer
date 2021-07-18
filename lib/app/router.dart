// import 'package:cash_analyzer/screens/detail/detailView.dart';
import 'package:cash_analyzer/screens/edit/editView.dart';
import 'package:cash_analyzer/screens/main/mainListView.dart';
import 'package:cash_analyzer/screens/detail/detailView.dart';
import 'package:cash_analyzer/screens/setting/setting.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainListViewHome.routeName:
        return MaterialPageRoute(builder: (_) => MainListViewHome());

      case DetailView.routeName:
        return MaterialPageRoute(
            builder: (context) => DetailView(
                  args: settings.arguments as DetailViewPageArguments,
                ));

      case EditView.routeName:
        return MaterialPageRoute(builder: (context) => EditView(
          args: settings.arguments as EditViewPageArguments,
        ));
        
      case '/setting':
        return MaterialPageRoute(builder: (_) => SettingPage());

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
