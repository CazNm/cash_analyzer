import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/screens/detail/detailView.dart';
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailView.routeName,
        arguments: DetailViewPageArguments(data.list, data.currentDate),
      ),
      child: Container(
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        decoration: BoxDecoration(
          color: salmon,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.builder(
          itemCount: data.list.length + 2,
          itemBuilder: (BuildContext context, int index) {
            Widget w;
            if (index == 0) {
              // first
              String dateString = DateFormat("MM-dd").format(data.currentDate);
              if (dateString == DateFormat("MM-dd").format(DateTime.now())) {
                dateString = "오늘의";
              }
              w = Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "$dateString 사용 내역",
                    style: whiteText(size: 16, fontWeight: FontWeight.w400),
                  ));
            } else if (index == data.list.length + 1) {
              // last
              w = Text(
                "....",
                style: whiteText(),
              );
            } else {
              w = PaymentSummaryTile(data.list[index - 1])
                  .build(context); // general
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: w,
            );
          },
        ),
      ),
    );
  }
}
