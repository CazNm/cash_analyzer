import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentInfo {
  int price;
  DateTime time;
  String desc;

  PaymentInfo(this.price, this.time, this.desc);
}

class PaymentSummaryTile {
  final PaymentInfo info;

  PaymentSummaryTile(this.info);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text("${info.price}원"),
            Text(DateFormat("HH:mm").format(info.time)),
            Text(info.desc),
          ],
        ));
  }
}

//         title: Text("${info.price}원"),
//         subtitle: Text(info.time.toString()),
//         trailing: Text(info.summary),
