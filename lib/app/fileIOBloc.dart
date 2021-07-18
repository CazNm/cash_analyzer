import 'dart:async';

import 'package:cash_analyzer/app/blocProvider.dart';

class FileIOBloc extends Bloc {
  final StreamController<Map<String, dynamic>> _controller = StreamController<Map<String, dynamic>>();

  FileIOBloc() {
    // _controller.stream.listen((event) { })
  }

  StreamSink<Map<String, dynamic>> get sink => _controller.sink;
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
