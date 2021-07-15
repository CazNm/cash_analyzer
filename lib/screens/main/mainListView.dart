import 'package:cash_analyzer/widgets/PaymentSummary.dart';
import 'package:flutter/material.dart';

class MainListViewHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainListViewHomeState();
  }
}


// When use stateful widget in Bloc using project
class MainListViewHomeState extends State<MainListViewHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cache = [
      PaymentInfo(30000, new DateTime.now(), "test payment1"),
      PaymentInfo(26498, new DateTime.now(), "test payment2"),
      PaymentInfo(15200, new DateTime.now(), "test payment3"),
      PaymentInfo(900, new DateTime.now(), "test payment4"),
      PaymentInfo(3600, new DateTime.now(), "test payment5"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Cazh Analyzer"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(4),
        child: ListView.builder(
          itemCount: cache.length,
          itemBuilder: (BuildContext context, int index) {
            return PaymentSummaryTile(cache[index]);
          },
        ),
      ),
      bottomNavigationBar: NavigationToolbar(
        trailing: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            print("setting button");
          },
        ),
      ),
    );
  }
}
