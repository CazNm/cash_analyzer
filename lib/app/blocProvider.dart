import 'package:cash_analyzer/app/bloc.dart';
import 'package:flutter/material.dart';
export 'bloc.dart';

class BlocProvider<T extends Bloc> extends InheritedWidget {
  final T bloc;

  BlocProvider({required Key key, required Widget child, required T bloc})
      : this.bloc = bloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static BlocProvider? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BlocProvider>());
  }
}
