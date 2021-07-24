import 'package:intl/intl.dart';

import 'package:cash_analyzer/app/index.dart';

import 'package:cash_analyzer/screens/edit/editView.dart';
import 'package:cash_analyzer/screens/main/PaymentSummary.dart';

class DetailViewPageArguments extends Object {
  final DateTime date;

  DetailViewPageArguments(this.date);
}

class DetailView extends StatefulWidget {
  static const routeName = '/detail';

  final DetailViewPageArguments args;

  DetailView({required this.args});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<DataProcessBloc>(context)!.bloc;
    Future.microtask(() {
      print('_DetailViewState.build microtask start');
      bloc.fetchPaymentList(this.widget.args.date);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: black48,
        body: StreamBuilder<List<PaymentInfo>>(
            stream: bloc.paymentStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildBody(context, snapshot.data!);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget buildBody(BuildContext context, List<PaymentInfo> data) {
    int use = 0;
    data.forEach((element) {
      use += element.price;
    });

    String dateString = DateFormat("MM-dd").format(this.widget.args.date);
    if (dateString == DateFormat("MM-dd").format(DateTime.now())) {
      dateString = "오늘의";
    }

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(48, 60, 48, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$dateString 사용 내역",
                style: whiteText(size: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                "총 : $use",
                style: whiteText(size: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: salmon,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PaymentSummaryTile(data[index], detail: true)
                                .build(context),
                          );
                        }),
                  ),
                ),
              ),
              dateString == "오늘의" ? Container(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  onPressed: () => service!.navigateTo(EditView.routeName,
                      arguments: EditViewPageArguments(this.widget.args.date)),
                  icon: Icon(Icons.add, color: white),
                  iconSize: 40,
                ),
              ) : Container(),
              SizedBox(
                height: height * (0.15),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            onPressed: () {
              bloc.fetchSessionData();
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel, color: white),
          ),
        )
      ],
    );
  }
}
