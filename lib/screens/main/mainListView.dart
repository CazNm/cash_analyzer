import 'package:cash_analyzer/app/index.dart';

import 'package:cash_analyzer/screens/main/GoalSection.dart';
import 'package:cash_analyzer/screens/main/PaymentList.dart';
import 'package:cash_analyzer/screens/main/PaymentSummary.dart';
import 'package:flutter/material.dart';
import 'package:cash_analyzer/data/file.dart';

class MainListViewHome extends StatefulWidget {
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return MainListViewHomeState();
  }
}

// When use stateful widget in Bloc using project
class MainListViewHomeState extends State<MainListViewHome> {
  final gData = GoalData(
      300000,
      150000,
      40000,
      DateTime.now().subtract(Duration(days: 15)),
      DateTime.now().add(Duration(days: 15)));

  final pData = [
    PaymentInfo(10000, DateTime.now(), "test payment1"),
    PaymentInfo(21000, DateTime.now(), "test payment2"),
    PaymentInfo(15000, DateTime.now(), "test payment3"),
    PaymentInfo(900, DateTime.now(), "test payment4"),
    PaymentInfo(3100, DateTime.now(), "test payment5"),
  ];

  @override
  void initState() {
    super.initState();
    print(saveDataList.length);
    print(width);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Cazh Analyzer"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            GoalSection(gData),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return PaymentList(
                    PaymentListData(pData, DateTime.now().subtract(Duration(days: index)))
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          print("setting button");
        },
      ),
    );
  }
}
