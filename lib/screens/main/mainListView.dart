import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/data/model.dart';

import 'package:cash_analyzer/screens/main/GoalSection.dart';
import 'package:cash_analyzer/screens/main/PaymentList.dart';
import 'package:cash_analyzer/screens/setting/setting.dart';
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
  final gData = SessionInfo(
      budget: 300000,
      totalUse: 150000,
      todayUse: 40000,
      sDay: DateTime.now().subtract(Duration(days: 15)),
      dDay: DateTime.now().add(Duration(days: 15)));

  final pData = [
    PaymentInfo(price: 10000, time: DateTime.now(), title: "test payment1"),
    PaymentInfo(price: 21000, time: DateTime.now(), title: "test payment2"),
    PaymentInfo(price: 15000, time: DateTime.now(), title: "test payment3"),
    PaymentInfo(price: 900, time: DateTime.now(), title: "test payment4"),
    PaymentInfo(price: 3100, time: DateTime.now(), title: "test payment5"),
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
        backgroundColor: black48,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                  flex: 35,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
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
          icon: Icon(Icons.settings, color: white),
          onPressed: () {
            service!.navigateTo(SettingPage.routeName);
            print("setting button");
          },
        ),
      ),
    );
  }
}
