import 'package:cash_analyzer/screens/main/PaymentSummary.dart';
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final paymentList = [
    PaymentInfo(10000, DateTime.now(), "test payment1"),
    PaymentInfo(21000, DateTime.now(), "test payment2"),
    PaymentInfo(15000, DateTime.now(), "test payment3"),
    PaymentInfo(900, DateTime.now(), "test payment4"),
    PaymentInfo(3100, DateTime.now(), "test payment5"),
  ];

  final date = DateTime.now();

  final use = 40000;

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
    // final data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Cazh Analyzer"),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Text("${date.toString()} 사용 내역"),
            Text("총 : ${use}"),
            Container(
              height: 400,
              child: ListView.builder(
                  itemCount: paymentList.length+1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == paymentList.length) {
                      return IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PaymentSummaryTile(paymentList[index]),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
