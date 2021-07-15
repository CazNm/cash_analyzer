import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cash_analyzer/screens/main/PaymentSummary.dart';

class PaymentListData {
  List<PaymentInfo> list;
  DateTime currentDate;

  PaymentListData(this.list, this.currentDate);
}

class PaymentList extends StatelessWidget {
  final PaymentListData data;

  const PaymentList(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: data.list.length + 1,
        itemBuilder: (BuildContext context, int index) {
          Widget w;
          if (index == 0) {
            String dateString = DateFormat("MM-dd").format(data.currentDate);
            if (dateString == DateFormat("MM-dd").format(DateTime.now())) {
              dateString = "오늘의";
            }
            w = Center(child: Text("$dateString 사용 내역"));
          } else {
            w = PaymentSummaryTile(data.list[index - 1]);
          }
          return Padding(
            padding: const EdgeInsets.only(top: 4),
            child: w,
          );
        },
      ),
    );
  }
}
