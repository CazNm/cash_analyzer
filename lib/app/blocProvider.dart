import 'package:cash_analyzer/app/bloc.dart';
import 'package:flutter/material.dart';
export 'bloc.dart';

// general type T inherit Bloc abstract class
// Any kind of Bloc can be possible
// like context's provider in react
class BlocProvider<T extends Bloc> extends InheritedWidget {
  // declaration final member bloc
  // diffrent between final and const is initialize timing
  // const variable must be initialize in compile time
  // but final variable can be initialize anytime
  final T bloc;

  // constructor using variable arguments
  // what's different?
  // BlocProvider({required Key key, required Widget child, required this.bloc})
  //     : super(key: key, child: child);
  // Key is important?
  BlocProvider({Key? key, required Widget child, required T bloc})
      : this.bloc = bloc,
        super(key: key, child: child);

  // allways re"draw" this widget wether values are change or not?
  // argument _ mean throw away it's argument?
  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static BlocProvider<T>? of<T extends Bloc>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>();
  }
}
