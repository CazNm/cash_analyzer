import 'package:flutter/material.dart';

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
    return ListTile(
      tileColor: Theme.of(context).primaryColorLight,
      title: Text("${info.price}원"),
      subtitle: Text(info.time.toString()),
      trailing: Text(info.summary),
    );
    
  }
}
