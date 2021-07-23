import 'dart:convert';

import 'package:cash_analyzer/utils/time.dart';

List<Map<String, dynamic>> list2Json(List list) {
  return List.generate(list.length, (index) => list[index].toJson());
}

class PaymentInfo {
  late String _title;
  late String? _desc;
  late DateTime _time;
  late int _price;
  late List<String>? _tags;

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _desc = json['desc'];
    _time = DateTime.parse(json['time']);
    _price = json['price'];
    _tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['title'] = _title;
    json['desc'] = _desc;
    json['time'] = jsonEncode(_time);
    json['price'] = _price;
    if (_tags != null) {
      json['tags'] = list2Json(_tags!);
    } else {
      json['tags'] = [];
    }

    return json;
  }

  String get title => _title;
  String? get desc => _desc;
  DateTime get time => _time;
  int get price => _price;
  List<String>? get tags => _tags;
}

class PaymentListPerDay {
  late DateTime _currentDate;
  late List<PaymentInfo> _paymentInfoList;

  PaymentListPerDay.fromJson(Map<String, dynamic> json) {
    _currentDate = json['date'];

    _paymentInfoList = List<PaymentInfo>.generate(
        json['paymentInfoList'].length,
        (index) => PaymentInfo.fromJson(json['paymentInfoList'][index]));
  }

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['date'] = jsonEncode(_currentDate);
    json['paymentInfoList'] = list2Json(_paymentInfoList);

    return json;
  }

  DateTime get currentDate => _currentDate;
  List<PaymentInfo> get paymentInfoList => _paymentInfoList;
}

class SessionInfo {
  late int budget;
  late int totalUse;
  late DateTime sDay;
  late DateTime dDay;

  SessionInfo(
      {required int budget,
      int totalUse = 0,
      required DateTime sDay,
      DateTime? dDay}) {
    budget = budget;
    totalUse = totalUse;
    sDay = sDay;
    if (dDay == null) {
      dDay = DateTime.parse(sDay.toString()).add(Duration(days: 30));
    } else {
      dDay = dDay;
    }
  }

  SessionInfo.fromJson(Map<String, dynamic> json) {
    budget = json['budget'];
    totalUse = json['totalUse'];
    sDay = DateTime.parse(json['sDay']);
    dDay = DateTime.parse(json['dDay']);
  }

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['budget'] = budget;
    json['totalUse'] = totalUse;
    json['sDay'] = jsonEncode(sDay);
    json['dDay'] = jsonEncode(dDay);

    return json;
  }

  bool isContain(DateTime date) {
    return sDay.isBefore(date) && date.isBefore(dDay);
  }
}

class SessionData {
  late SessionInfo _sessionInfo;
  late List<PaymentListPerDay> _paymentListData;

  SessionData(
      {required SessionInfo sessionInfo,
      List<PaymentListPerDay>? paymentListData}) {
    _sessionInfo = sessionInfo;
    if (paymentListData == null) {
      _paymentListData = List<PaymentListPerDay>.empty();
    } else {
      _paymentListData = paymentListData;
    }
  }

  SessionData.fromJson(Map<String, dynamic> json) {
    _sessionInfo = SessionInfo.fromJson(json['sessionInfo']);

    _paymentListData = List<PaymentListPerDay>.generate(
        json['paymentListData'].length,
        (index) => PaymentListPerDay.fromJson(json['paymentListData'][index]));
  }

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['sessionInfo'] = _sessionInfo.toJson();
    json['paymentListData'] = list2Json(_paymentListData);

    return json;
  }

  SessionInfo get sessionInfo => _sessionInfo;
  List<PaymentListPerDay> get paymentListData => _paymentListData;
}

class DataModel {
  late List<SessionData> _sessionList = List<SessionData>.empty();

  DataModel();

  DataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      _sessionList.add(SessionData.fromJson(element));
    });
  }

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['data'] = list2Json(_sessionList);

    return json;
  }

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

  PaymentListPerDay? findDate(DateTime date) {
    SessionData? currentSession = findSession(date);
    if (currentSession != null) {
      DateTime dateOnly = removeTime(date);
      for (var i = 0; i < currentSession._paymentListData.length; i++) {
        PaymentListPerDay pd = currentSession._paymentListData[i];
        if (dateOnly.compareTo(pd._currentDate) == 0) {
          return pd;
        }
      }
    }
  }
}
