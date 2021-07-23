import 'package:cash_analyzer/data/model.dart';
import 'package:cash_analyzer/utils/time.dart';

class SessionData {
  late SessionInfo _sessionInfo;
  late Map<String, List<PaymentInfo>> _paymentListData;

  SessionData(SessionInfo sessionInfo)
      : _sessionInfo = sessionInfo,
        _paymentListData = {};

  SessionData.fromJson(Map<String, dynamic> jsonData)
      : _sessionInfo = SessionInfo.fromJson(jsonData['sessionInfo']),
        _paymentListData = Map.fromIterable(
          jsonData['paymentListData'],
          value: (element) => List<PaymentInfo>.generate(
              element.length, (index) => PaymentInfo.fromJson(element[index])),
        );
  // _paymentListData = {};
  // jsonData['paymentListData'].forEach((key, value) {
  //   _paymentListData[key] = PaymentListPerDay.fromJson(value);

  Map<String, dynamic> toJson() => {
        'sessionInfo': _sessionInfo,
        'paymentListData': _paymentListData,
      };

  SessionInfo get sessionInfo => _sessionInfo;
  Map<String, List<PaymentInfo>> get paymentListData => _paymentListData;

  List<PaymentInfo>? findDate(DateTime date) {
    DateTime dateOnly = removeTime(date);
    return _paymentListData[dateOnly.toIso8601String()];
  }

  void addPayment(PaymentInfo paymentInfo, {DateTime? date}) {
    if (date != null) {}
  }
}