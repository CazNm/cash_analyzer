// import 'package:cash_analyzer/screens/detail/DetailPage.dart';
import 'package:cash_analyzer/screens/edit/editPage.dart';
import 'package:cash_analyzer/screens/main/mainPage.dart';
import 'package:cash_analyzer/screens/detail/detailPage.dart';
import 'package:cash_analyzer/screens/setting/settingPage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        return MaterialPageRoute(builder: (_) => MainPage());

      case DetailPage.routeName:
        return MaterialPageRoute(
            builder: (context) => DetailPage(
                  args: settings.arguments as DetailPageArguments,
                ));

      case EditPage.routeName:
        return MaterialPageRoute(builder: (context) => EditPage(
          args: settings.arguments as EditPageArguments,
        ));

      case SettingPage.routeName:
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
