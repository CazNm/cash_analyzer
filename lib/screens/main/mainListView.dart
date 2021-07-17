import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/widgets/PaymentSummary.dart';
import 'package:flutter/material.dart';
import 'package:cash_analyzer/data/file.dart';

class MainListViewHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainListViewHomeState();
  }
}

// When use stateful widget in Bloc using project
class MainListViewHomeState extends State<MainListViewHome> {
  final cache = [
    PaymentInfo(30000, new DateTime.now(), "test payment1"),
    PaymentInfo(26498, new DateTime.now(), "test payment2"),
    PaymentInfo(15200, new DateTime.now(), "test payment3"),
    PaymentInfo(900, new DateTime.now(), "test payment4"),
    PaymentInfo(3600, new DateTime.now(), "test payment5"),
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
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned(
                  child: Column(children: [Text("목표 금액"), Text("오늘 사용 금액")])),
              Container(
                margin: EdgeInsets.fromLTRB(0, 180, 0, 0),
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: width,
                height: 161,
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: cache.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PaymentSummaryTile(cache[index]).build;
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                saveDataList.add(saveDataList[0]);
                saveLocalData({"data": saveDataList});
                print("save data");
              },
            ),
            SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.note),
              onPressed: () async {
                final _data = await loadLocalData();
                print(_data["data"]);
                saveDataList = _data["data"];
                print(saveDataList.length);
                print("load data");
              },
            ),
          ],
        ));
  }
}
