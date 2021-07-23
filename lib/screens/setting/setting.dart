import 'package:cash_analyzer/app/index.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting';

  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  WhiteCheckCircle _salmon = WhiteCheckCircle(checkValue: true);
  WhiteCheckCircle _lightBlue = WhiteCheckCircle(checkValue: false);

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
    return SafeArea(
      child: Scaffold(
          backgroundColor: black48,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    colorOption(),
                    SizedBox(height: 30),
                    noticeOption(),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel, color: white),
                ),
              )
            ],
          )),
    );
  }

  Widget colorOption() {
    return Row(children: [
      Text("Theme Color : ",
          style: whiteText(size: 20, fontWeight: FontWeight.bold)),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 35,
          width: 35,
          color: salmon),
      _salmon.build,
      SizedBox(
        width: 15,
      ),
      Container(
          margin: EdgeInsets.only(right: 10),
          height: 35,
          width: 35,
          color: lightBlue),
      _lightBlue.build
    ]);
  }

  Widget noticeOption() {
    return Row(
      children: [
        Text("Notice ME! : ",
            style: whiteText(size: 20, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Text("no", style: whiteText()),
            Switch(value: false, onChanged: (value) {}),
            Text("yes", style: whiteText()),
          ],
        )
      ],
    );
  }
}

class WhiteCheckCircle {
  bool checkValue = false;

  WhiteCheckCircle({required this.checkValue});

  Widget get build => StatefulBuilder(
        builder: (context, setState) {
          return InkWell(
            onTap: () {
              setState(() {
                checkValue = !checkValue;
              });
            },
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 2, color: white)),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: this.checkValue ? white : Color.fromRGBO(0, 0, 0, 0),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          );
        },
      );
}
