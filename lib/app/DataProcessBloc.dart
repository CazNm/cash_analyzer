import 'dart:async';

import 'package:cash_analyzer/app/blocProvider.dart';
import 'package:cash_analyzer/app/index.dart';
import 'package:cash_analyzer/data/model.dart';

class DataProcessBloc extends Bloc {
  final _sessionDataController = StreamController<SessionData>.broadcast();
  final _paymentsController = StreamController<List<PaymentInfo>>.broadcast();
  final _settingController = StreamController<Settings>.broadcast();

  DataProcessBloc() {
    // _settingController.stream.listen(_editSettings);
  }

  void dispose() {
    _sessionDataController.close();
    _paymentsController.close();
    _settingController.close();
  }

  Stream<SessionData> get sessionDataStream => _sessionDataController.stream;
  Stream<List<PaymentInfo>> get paymentStream => _paymentsController.stream;
  Stream<Settings> get settingStream => _settingController.stream;

  void fetchSessionData() async {
    final data = await repo.loadData();

    _sessionDataController.add(data.currentSession);
    print("fetchSessionData success");
  }

  void fetchPaymentList(DateTime date) async {
    final data = await repo.loadData();
    var sessionData = data.findSession(date);
    if (sessionData != null) {
      List<PaymentInfo>? list = sessionData.findDate(date);
      if (list != null) {
        _paymentsController.add(list);
        print("fetchPaymentList success");
        return;
      }
    }

    _paymentsController.addError(
        "error in fetchPaymentList: cannot found date ${date.toString()}");
  }

  void fetchSettings() async {
    final data = await repo.loadData();

    _settingController.add(data.settings);
  }

  Future<bool> editNotice(bool value) async {
    final data = await repo.loadData();
    data.settings.notice = value;
    if (await repo.saveData()) {
      _settingController.add(data.settings);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> toggleTheme(String value) async {
    final data = await repo.loadData();
    data.settings.theme = value;
    if (await repo.saveData()) {
      _settingController.add(data.settings);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editNextBudget(int value) async {
    final data = await repo.loadData();
    data.settings.nextBudget = value;
    if (await repo.saveData()) {
      _settingController.add(data.settings);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changeBudget(int budget) async {
    final data = await repo.loadData();

    if (data.currentSession.sessionInfo.editable) {
      data.currentSession.sessionInfo.budget = budget;
      if (await repo.saveData()) {
        _sessionDataController.add(data.currentSession);
        return true;
      }
    }

    return false;
  }

  Future<bool> editTotalUseOfCurrentSession(int value) async {
    final data = await repo.loadData();

    data.currentSession.sessionInfo.addTotalUse(value);
    if (await repo.saveData()) {
      _sessionDataController.add(data.currentSession);
      return true;
    }

    return false;
  }

  Future<bool> addPayment(PaymentInfo paymentInfo) async {
    final data = await repo.loadData();

    DateTime currentDate = paymentInfo.time;
    List<PaymentInfo>? paymentList =
        data.findSession(currentDate)!.findDate(currentDate);
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
    final data = await repo.loadData();

    DateTime currentDate = paymentInfo.time;
    List<PaymentInfo>? paymentList =
        data.findSession(currentDate)!.findDate(currentDate);
    if (paymentList != null) {
      paymentList.removeWhere((element) =>
          element.time == paymentInfo.time &&
          element.title == paymentInfo.title &&
          element.price == paymentInfo.price);
      data.currentSession.sessionInfo.addTotalUse(-paymentInfo.price);
      if (await repo.saveData()) {
        _paymentsController.add(paymentList);
        return true;
      }
    }

    return false;
  }
}
