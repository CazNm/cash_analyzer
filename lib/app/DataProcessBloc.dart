import 'dart:async';

import 'package:cash_analyzer/app/blocProvider.dart';
import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/data/model.dart';

class DataProcessBloc extends Bloc {
  final _sessionDataController = StreamController<SessionData>.broadcast();
  final _sessionInfoController = StreamController<SessionInfo>.broadcast();
  final _paymentsController = StreamController<List<PaymentInfo>>.broadcast();

  DataProcessBloc() {
    // _sessionInfoController.stream.listen(_addData);
  }

  void dispose() {
    _sessionDataController.close();
    _sessionInfoController.close();
    _paymentsController.close();
  }

  Stream<SessionData> get sessionDataStream => _sessionDataController.stream;
  Stream<SessionInfo> get sessionInfoStream => _sessionInfoController.stream;
  Stream<List<PaymentInfo>> get paymentStream => _paymentsController.stream;
  // StreamSink<PaymentInfo> get eventSink => _eventController.sink;

  void fetchSessionData() async {
    final data = repo.data;
    if (data != null) {
      _sessionDataController.add(data.currentSession);
    } else {
      _sessionDataController.addError("error in fetchSessionData: data is null");
    }
  }

  void fetchPaymentList(DateTime date) async {
    List<PaymentInfo>? list = repo.data!.findSession(date)!.findDate(date);
    if (list != null) {
      _paymentsController.add(list);
    } else {
      _paymentsController.addError("error in fetchPaymentList: cannot found current date");
    }
  }

  Future<bool> addNewSession(SessionInfo sessionInfo) async {
    repo.data!.allSessions.insert(0, SessionData(sessionInfo));
    if (await repo.saveData()) {
      _sessionInfoController.add(repo.data!.currentSession.sessionInfo);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editCurrentSessionInfo(SessionInfo sessionInfo) async {
    repo.data!.currentSession.sessionInfo.copyValue(sessionInfo);
    if (await repo.saveData()) {
      _sessionInfoController.add(repo.data!.currentSession.sessionInfo);
      return true;
    }

    return false;
  }

  Future<bool> addPayment(PaymentInfo paymentInfo) async {
    DateTime currentDate = paymentInfo.time;
    List<PaymentInfo>? paymentList =
        repo.data!.findSession(currentDate)!.findDate(currentDate);
    if (paymentList != null) {
      paymentList.add(paymentInfo);
      if (await repo.saveData()) {
        _paymentsController.add(paymentList);
        return true;
      }
    }

    return false;
  }

  Future<bool> removePayment(PaymentInfo paymentInfo) async {
    DateTime currentDate = paymentInfo.time;
    List<PaymentInfo>? paymentList =
        repo.data!.findSession(currentDate)!.findDate(currentDate);
    if (paymentList != null) {
      paymentList.removeWhere((element) => element.time == currentDate);
      if (await repo.saveData()) {
        _paymentsController.add(paymentList);
        return true;
      }
    }

    return false;
  }
}
