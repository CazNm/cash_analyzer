import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentInfo {
  int price;
  DateTime time;
  String summary;

  PaymentInfo(this.price, this.time, this.summary);
}

class PaymentSummaryTile extends StatelessWidget {
  final PaymentInfo info;

  const PaymentSummaryTile(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Text("${info.price}원"),
        Text(DateFormat("HH:mm").format(info.time)),
        Text(info.summary),
      ],)
    );
    
  }
}
