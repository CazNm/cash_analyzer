import 'dart:async';

import 'package:cash_analyzer/app/blocProvider.dart';
import 'package:cash_analyzer/data/file.dart';

class DataProcessBloc extends Bloc {
  final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>();
  late Map<String, dynamic> data;

  DataProcessBloc() {
    // _controller.stream.listen((event) { })
  }

  StreamSink<Map<String, dynamic>> get sink => _controller.sink;
  Stream<Map<String, dynamic>> get stream => _controller.stream;


  void fetchData() async {
    data = await loadLocalData();
    _controller.sink.add(data);
  }

  void dispose() {
    _controller.close();
  }
}
