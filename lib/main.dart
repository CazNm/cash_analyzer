import 'package:flutter/services.dart';

import 'package:cash_analyzer/app/index.dart';

import 'package:cash_analyzer/screens/main/mainPage.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CustomRouter router = CustomRouter();

  @override
  Widget build(BuildContext context) {
    bloc.fetchSettings();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0.5)));

    return StreamBuilder<Settings>(
        stream: bloc.settingStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildBody(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildBody(Settings data) {
    Color accentColor = data.theme == 'salmon' ? white : black;
    ThemeData appTheme = ThemeData(
        accentColor: accentColor,
        primaryColor: primaryColorList[data.theme],
        backgroundColor: black48,
        textTheme: TextTheme(
          headline1: defaultText(white, size: 28, fontWeight: FontWeight.bold),
          headline2: defaultText(white, size: 22, fontWeight: FontWeight.bold),
          headline3: defaultText(white, size: 22),
          headline4: defaultText(white, size: 18),
          headline5: defaultText(white),
          bodyText1:
              defaultText(accentColor, size: 16, fontWeight: FontWeight.w400),
          bodyText2: defaultText(accentColor),
        ),
        iconTheme: IconThemeData(color: accentColor));

    return MaterialApp(
      theme: appTheme,
      title: 'Flutter Demo',
      onGenerateRoute: router.generateRoute,
      home: MainPage(),
      navigatorKey: service!.navigatorKey,
    );
  }
}
