export 'package:flutter/material.dart';
export 'style.dart';
export 'router.dart';
export 'dart:async';
export 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

// GetIt manage factory fuctions and singletons witch is globaly, frequently used?
GetIt locator = GetIt.instance;
NavigationService? service; // it use gps??

/*** About Null Safety ***
 * ? after variable mean this var can be null
 * ! after variable mean this var is sure not to contain Null
 * -> normally, ! uses question_declared variable because other variable type always contain proper value
 * plus, late some_var_type some_var_name mean this var can be assigned later & sure not to be Null
 * -> we cannot declare variable without initializing basically?
 * oh shit;
 */

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
