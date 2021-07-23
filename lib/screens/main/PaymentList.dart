import 'package:intl/intl.dart';

import 'package:cash_analyzer/app/index.dart';

import 'package:cash_analyzer/screens/main/PaymentSummary.dart';
import 'package:cash_analyzer/screens/detail/detailView.dart';

class PaymentListData {
  DateTime currentDate;
  List<PaymentInfo> paymentInfoList;

  PaymentListData(this.currentDate, this.paymentInfoList);
}

class PaymentList extends StatelessWidget {
  final PaymentListData data;

  const PaymentList(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => service!.navigateTo(
        DetailView.routeName,
        arguments: DetailViewPageArguments(data.currentDate),
      ),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: salmon,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ListView.builder(
            itemCount: data.paymentInfoList.length + 2,
            itemBuilder: (BuildContext context, int index) {
              Widget w;
              if (index == 0) {
                // first
                String dateString =
                    DateFormat("MM-dd").format(data.currentDate);
                if (dateString == DateFormat("MM-dd").format(DateTime.now())) {
                  dateString = "오늘의";
                }
                w = Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "$dateString 사용 내역",
                      style: whiteText(size: 16, fontWeight: FontWeight.w400),
                    ));
              } else if (index == data.paymentInfoList.length + 1) {
                // last
                w = Text(
                  "....",
                  style: whiteText(),
                );
              } else {
                w = PaymentSummaryTile(data.paymentInfoList[index - 1])
                    .build(context); // general
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
                child: w,
              );
            },
          ),
        ),
      ),
    );
  }
}
