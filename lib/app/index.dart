import 'package:cash_analyzer/app/DataProcessBloc.dart';
import 'package:cash_analyzer/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

export 'package:flutter/material.dart';
export 'style.dart';
export 'router.dart';
export 'dart:async';
export 'dart:convert';
export 'package:cash_analyzer/data/model.dart';
export 'package:cash_analyzer/app/DataProcessBloc.dart';
export 'package:cash_analyzer/app/blocProvider.dart';

// GetIt manage factory fuctions and singletons witch is globaly, frequently used?
GetIt locator = GetIt.instance;
NavigationService? service;
late DataRepository repo;
DataProcessBloc bloc = DataProcessBloc();

BuildContext? context = service!.navigatorKey.currentContext;

double width = MediaQuery.of(context!).size.width;
double height = MediaQuery.of(context!).size.height;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushRemoveUntil(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  service = locator<NavigationService>();

  locator.registerLazySingleton(() => DataRepository());
  repo = locator<DataRepository>();
  
  // locator.registerLazySingleton(() => DataProcessBloc());
  // bloc = locator<DataProcessBloc>();
}
