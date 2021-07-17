import 'package:cash_analyzer/screens/main/mainListView.dart';
import 'package:cash_analyzer/app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CustomRouter router = CustomRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0.5)));
    return MaterialApp(
      theme: ThemeData(),
      title: 'Flutter Demo',
      onGenerateRoute: router.generateRoute,
      home: MainListViewHome(),
      navigatorKey: service!.navigatorKey,
    );
  }

}

