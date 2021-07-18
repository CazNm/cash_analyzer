import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cash_analyzer/app/index.dart';

class PaymentInfo {
  int price;
  DateTime time;
  String summary;

  PaymentInfo(this.price, this.time, this.summary);
}

class PaymentSummaryTile {
  final PaymentInfo info;
  final bool detail;

  PaymentSummaryTile(this.info, {this.detail = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 7),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: white))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat("HH:mm").format(info.time),
                style: whiteText(size: detail ? 18 : 14, lineHeight: 1.2)),
            SizedBox(height: 2),
            Text(info.summary,
                style: whiteText(size: detail ? 16 : 12, lineHeight: 1.2)),
            Text("${info.price}원",
                style: whiteText(size: detail ? 16 : 12, lineHeight: 1.2)),
          ],
        ));
  }
}

//  title: Text("${info.price}원"),
//         subtitle: Text(info.time.toString()),
//         trailing: Text(info.summary),
