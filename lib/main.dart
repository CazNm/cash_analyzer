import 'package:cash_analyzer/app/index.dart';
import 'package:flutter/material.dart';

import 'mainList/mainListView.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // BuildContext is something like tree of current widget's bellow?
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MainListViewHome(),
    );
  }
}
