export 'package:flutter/material.dart';
export 'style.dart';
export 'router.dart';
export 'dart:async';
export 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
NavigationService? service;

BuildContext? context = service!.navigatorKey.currentContext;

double width = MediaQuery.of(context!).size.width;
double height = MediaQuery.of(context!).size.height;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> pushRemoveUntil(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  service = locator<NavigationService>();
}
