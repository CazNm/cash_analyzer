import 'package:cash_analyzer/screens/main/mainListView.dart';
import 'package:cash_analyzer/app/index.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CustomRouter router = CustomRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      onGenerateRoute: router.generateRoute,
      home: MainListViewHome(),
    );
  }
}
