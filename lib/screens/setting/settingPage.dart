import 'package:cash_analyzer/app/index.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting';

  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  // bool themeValue = false;
  WhiteCheckCircle _salmon = WhiteCheckCircle(checkValue: true);
  WhiteCheckCircle _lightBlue = WhiteCheckCircle(checkValue: false);

  @override
  void initState() {
    super.initState();
    Future.microtask(() => bloc.fetchSettings());
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
          body: StreamBuilder<Settings>(
              stream: bloc.settingStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildBody(context, snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
    );
  }

  Widget buildBody(BuildContext context, Settings settings) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 80),
              colorOption(settings),
              SizedBox(height: 30),
              noticeOption(settings),
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
    );
  }

  Widget colorOption(Settings settings) {
    switch (settings.theme) {
      case 'salmon':
        _salmon.checkValue = true;
        _lightBlue.checkValue = false;
        break;
      case 'lightBlue':
        _salmon.checkValue = false;
        _lightBlue.checkValue = true;
        break;
      default:
    }
    return Row(children: [
      Text("Theme Color : ",
          style: whiteText(size: 20, fontWeight: FontWeight.bold)),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 35,
          width: 35,
          color: salmon),
      _salmon.build(() {
        _salmon.checkValue = true;
        _lightBlue.checkValue = false;
        bloc.toggleTheme('salmon');
        setState(() {});
      }),
      SizedBox(
        width: 15,
      ),
      Container(
          margin: EdgeInsets.only(right: 10),
          height: 35,
          width: 35,
          color: lightBlue),
      _lightBlue.build(() {
        _salmon.checkValue = false;
        _lightBlue.checkValue = true;
        bloc.toggleTheme('lightBlue');
        setState(() {});
      })
    ]);
  }

  Widget noticeOption(Settings settings) {
    return Row(
      children: [
        Text("Notice ME! : ",
            style: whiteText(size: 20, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Text("no", style: whiteText()),
            Switch(
                value: settings.notice,
                onChanged: (value) {
                  bloc.editNotice(value);
                }),
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

  Widget build(VoidCallback callback) => InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onTap: callback,
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
}
