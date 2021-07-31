import 'package:cash_analyzer/data/model.dart';
import 'package:cash_analyzer/utils/time.dart';

class SessionData {
  late SessionInfo _sessionInfo;
  late Map<String, List<PaymentInfo>> _paymentListData;

  SessionData(SessionInfo sessionInfo)
      : _sessionInfo = sessionInfo,
        _paymentListData = {} {
    findDate(DateTime.now());
  }

  SessionData.fromJson(Map<String, dynamic> jsonData)
      : _sessionInfo = SessionInfo.fromJson(jsonData['sessionInfo']) {
    _paymentListData = {};
    jsonData['paymentListData'].forEach((key, value) {
      _paymentListData[key] = List<PaymentInfo>.generate(
          value.length, (index) => PaymentInfo.fromJson(value[index]), growable: true);
    });
    
    findDate(DateTime.now());
  }

  Map<String, dynamic> toJson() => {
        'sessionInfo': _sessionInfo,
        'paymentListData': _paymentListData,
      };

  SessionInfo get sessionInfo => _sessionInfo;
  Map<String, List<PaymentInfo>> get paymentListData {
    return _paymentListData;
  }

  List<PaymentInfo>? findDate(DateTime date) {
    String dateStr = removeTime(date).toIso8601String();
    if (_sessionInfo.isContain(date)) {
      if (!_paymentListData.containsKey(dateStr)) {
        _paymentListData[dateStr] = List<PaymentInfo>.empty(growable: true);
      }
      return _paymentListData[dateStr];
    }
  }
}
