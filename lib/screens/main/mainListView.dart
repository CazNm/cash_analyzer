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
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey48,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Expanded(
                  flex: 35,
                  child: Column(
                    children: [
                      SizedBox(height: 70),
                      GoalSection(gData),
                    ],
                  )),
              Expanded(
                flex: 65,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(bottom: 30),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 350),
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(right: index != 1 ? 18 : 0),
                          child: PaymentList(PaymentListData(pData,
                              DateTime.now().subtract(Duration(days: index)))),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            print("setting button");
          },
        ),
      ),
    );
  }
}
