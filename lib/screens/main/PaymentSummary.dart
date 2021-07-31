import 'package:intl/intl.dart';

import 'package:cash_analyzer/app/index.dart';

class PaymentSummaryTile {
  final PaymentInfo info;
  final bool detail;

  PaymentSummaryTile(this.info, {this.detail = false});

  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<DataProcessBloc>(context)!.bloc;

    return Container(
        padding: EdgeInsets.only(bottom: 7),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).accentColor))),
        child: Material(
          type: MaterialType.transparency,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat("HH:mm").format(info.time),
                      style: detail
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.bodyText2),
                  SizedBox(height: 2),
                  Text(info.title,
                      style: detail
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.bodyText2),
                  Text("${info.price}원",
                      style: detail
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.bodyText2),
                ],
              ),
              detail
                  ? IconButton(
                      onPressed: () {
                        bloc.removePayment(info);
                      },
                      icon: Icon(Icons.delete, color: Theme.of(context).iconTheme.color),
                      iconSize: 20,
                      splashRadius: 20,
                    )
                  : Container(),
            ],
          ),
        ));
  }
}

//         title: Text("${info.price}원"),
//         subtitle: Text(info.time.toString()),
//         trailing: Text(info.summary),
