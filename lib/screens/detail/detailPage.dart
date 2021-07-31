import 'package:intl/intl.dart';

import 'package:cash_analyzer/app/index.dart';

import 'package:cash_analyzer/screens/edit/editPage.dart';
import 'package:cash_analyzer/screens/main/PaymentSummary.dart';

class DetailPageArguments extends Object {
  final DateTime date;

  DetailPageArguments(this.date);
}

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final DetailPageArguments args;

  DetailPage({required this.args});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // print('_DetailPageState.build microtask start');
      bloc.fetchPaymentList(this.widget.args.date);
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<DataProcessBloc>(context)!.bloc;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 6),
              Text(
                "총 : $use",
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 50),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
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
                  onPressed: () => service!.navigateTo(EditPage.routeName,
                      arguments: EditPageArguments(this.widget.args.date)),
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
