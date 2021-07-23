import 'package:cash_analyzer/utils/time.dart';

class PaymentInfo {
  late String _title;
  late String? _desc;
  late DateTime _time;
  late int _price;
  late List<String>? _tags;

  PaymentInfo(
      {required String title,
      String? desc,
      required DateTime time,
      required int price,
      List<String>? tags})
      : _title = title,
        _desc = desc,
        _time = time,
        _price = price,
        _tags = tags;

  PaymentInfo.fromJson(Map<String, dynamic> jsonData)
      : _title = jsonData['title'],
        _desc = jsonData['desc'],
        _time = DateTime.parse(jsonData['time']),
        _price = jsonData['price'],
        _tags = jsonData['tags'];

  Map<String, dynamic> toJson() => {
        'title': _title,
        'desc': _desc,
        'time': _time.toIso8601String(),
        'price': _price,
        'tags': _tags!,
      };

  String get title => _title;
  String? get desc => _desc;
  DateTime get time => _time;
  int get price => _price;
  List<String>? get tags => _tags;
}

class SessionInfo {
  late int budget;
  late int totalUse;
  late int todayUse;
  late DateTime sDay;
  late DateTime dDay;

  SessionInfo(
      {required this.budget,
      this.totalUse = 0,
      this.todayUse = 0,
      required this.sDay,
      DateTime? dDay}) {
    if (dDay == null) {
      dDay = DateTime.parse(sDay.toString()).add(Duration(
          days: 30)); // TODO: change this value to reference config's value
    } else {
      dDay = dDay;
    }
  }

  SessionInfo.fromJson(Map<String, dynamic> jsonData)
      : budget = jsonData['budget'],
        totalUse = jsonData['totalUse'],
        sDay = DateTime.parse(jsonData['sDay']),
        dDay = DateTime.parse(jsonData['dDay']);

  Map<String, dynamic> toJson() => {
        'budget': budget,
        'totalUse': totalUse,
        'sDay': sDay.toIso8601String(),
        'dDay': sDay.toIso8601String(),
      };

  bool isContain(DateTime date) {
    return sDay.isBefore(date) && date.isBefore(dDay);
  }
}

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

class DataModel {
  late List<SessionData> _sessionList;

  DataModel() : _sessionList = List<SessionData>.empty();

  DataModel.fromJson(Map<String, dynamic> jsonData)
      : _sessionList = List<SessionData>.generate(jsonData['data'].length,
            (index) => SessionData.fromJson(jsonData['data'][index]));

  Map<String, dynamic> toJson() => {
        'data': _sessionList,
      };

  List<SessionData> get allSessions => _sessionList;
  SessionData get currentSession => _sessionList[0];

  SessionData? findSession(DateTime date) {
    DateTime dateOnly = removeTime(date);
    for (int i = 0; i < _sessionList.length; i++) {
      SessionData session = _sessionList[i];
      if (session._sessionInfo.isContain(dateOnly.add(Duration(seconds: 1)))) {
        return session;
      }
    }
  }
}
