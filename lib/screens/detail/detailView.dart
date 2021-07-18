import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/screens/edit/editView.dart';
import 'package:cash_analyzer/screens/main/PaymentSummary.dart';
import 'package:flutter/material.dart';

class DetailViewPageArguments extends Object {
  final List<PaymentInfo> paymentList;
  final DateTime date;

  DetailViewPageArguments(this.paymentList, this.date);
}

class DetailView extends StatefulWidget {
  static const routeName = '/detail';

  final DetailViewPageArguments args;

  DetailView({required this.args});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  // final paymentList = [
  //   PaymentInfo(10000, DateTime.now(), "test payment1"),
  //   PaymentInfo(21000, DateTime.now(), "test payment2"),
  //   PaymentInfo(15000, DateTime.now(), "test payment3"),
  //   PaymentInfo(900, DateTime.now(), "test payment4"),
  //   PaymentInfo(3100, DateTime.now(), "test payment5"),
  // ];

  // final date = DateTime.now();

  // final use = 40000;

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
    final data = this.widget.args;

    int use = 0;
    data.paymentList.forEach((element) {
      use += element.price;
    });

    return SafeArea(
      child: Scaffold(
          backgroundColor: black48,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(48, 60, 48, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.date.toString()} 사용 내역",
                      style: whiteText(size: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "총 : $use",
                      style: whiteText(size: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: salmon,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ListView.builder(
                              itemCount: data.paymentList.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == data.paymentList.length) {
                                  return Container(
                                    alignment: Alignment.bottomLeft,
                                    child: IconButton(
                                      onPressed: () => service!.navigateTo(
                                        EditView.routeName,
                                        arguments: EditViewPageArguments(data.date)
                                      ),
                                      icon: Icon(Icons.add, color: white),
                                      iconSize: 40,
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PaymentSummaryTile(
                                          data.paymentList[index],
                                          detail: true)
                                      .build(context),
                                );
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.2),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel, color: white),
                ),
              )
            ],
          )),
    );
  }
}
