import 'package:flutter/material.dart';

class PaymentInfo {
  int price;
  DateTime time;
  String summary;

  PaymentInfo(this.price, this.time, this.summary);
}

class PaymentSummaryTile {
  final PaymentInfo info;

  PaymentSummaryTile(this.info);

  Widget get build => Container(
        constraints: BoxConstraints(maxHeight: 161, maxWidth: 100),
        margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
        decoration: BoxDecoration(
            color: Colors.amberAccent, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${info.price}원"),
            Text(info.time.toString()),
            Text(info.summary),
          ],
        ),
      );
}

//  title: Text("${info.price}원"),
//         subtitle: Text(info.time.toString()),
//         trailing: Text(info.summary),
