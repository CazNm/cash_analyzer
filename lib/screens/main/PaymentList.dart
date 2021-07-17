import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/screens/main/PaymentSummary.dart';
import 'package:cash_analyzer/screens/detail/detailView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentListData {
  List<PaymentInfo> paymentInfoList;
  DateTime currentDate;

  PaymentListData(this.paymentInfoList, this.currentDate);
}

class PaymentList extends StatelessWidget {
  final PaymentListData data;

  const PaymentList(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => service!.navigateTo(
        DetailView.routeName,
        arguments: DetailViewPageArguments(data.paymentInfoList, data.currentDate),
      ),
      child: Container(
        width: 200,
        margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView.builder(
          itemCount: data.paymentInfoList.length + 2,
          itemBuilder: (BuildContext context, int index) {
            Widget w;
            if (index == 0) {
              // first
              String dateString = DateFormat("MM-dd").format(data.currentDate);
              if (dateString == DateFormat("MM-dd").format(DateTime.now())) {
                dateString = "오늘의";
              }
              w = Center(child: Text("$dateString 사용 내역"));
            } else if (index == data.paymentInfoList.length + 1) {
              // last
              w = Text("....");
            } else {
              w = PaymentSummaryTile(data.paymentInfoList[index - 1])
                  .build(context); // general
            }
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: w,
            );
          },
        ),
      ),
    );
  }
}
