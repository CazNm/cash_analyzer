import 'package:cash_analyzer/data/file.dart';
import 'package:cash_analyzer/utils/time.dart';

// TODO: all class must be null safty

class PaymentInfo {
  late String _title;
  late String? _desc;
  late DateTime _time;
  late int _price;
  late List<String>? _tags;

  PaymentInfo.fromJson(Map<String, dynamic> parsedJson) {
    _title = parsedJson["title"];
    _desc = parsedJson["desc"];
    _time = DateTime.parse(parsedJson["time"]);
    _price = parsedJson["price"];
    _tags = parsedJson["tags"];
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

  PaymentListPerDay.fromJson(Map<String, dynamic> parsedJson) {
    _currentDate = parsedJson["date"];

    _paymentInfoList = List<PaymentInfo>.generate(
        parsedJson['paymentInfoList'].length,
        (index) => PaymentInfo.fromJson(parsedJson['paymentInfoList'][index]));
  }

  DateTime get currentDate => _currentDate;
  List<PaymentInfo> get paymentInfoList => _paymentInfoList;
}

class SessionInfo {
  late int _budget;
  late int _totalUse;
  late DateTime _sDay;
  late DateTime _dDay;

  SessionInfo(
      {required int budget,
      int totalUse = 0,
      required DateTime sDay,
      DateTime? dDay}) {
    _budget = budget;
    _totalUse = totalUse;
    _sDay = sDay;
    if (dDay == null) {
      _dDay = DateTime.parse(sDay.toString()).add(Duration(days: 30));
    } else {
      _dDay = dDay;
    }
  }

  SessionInfo.fromJson(Map<String, dynamic> parsedJson) {
    _budget = parsedJson["budget"];
    _totalUse = parsedJson["totalUse"];
    _sDay = DateTime.parse(parsedJson["sDay"]);
    _dDay = DateTime.parse(parsedJson["dDay"]);
  }

  int get budget => _budget;
  int get totalUse => _totalUse;
  DateTime get sDay => _sDay;
  DateTime get dDay => _dDay;

  bool isContain(DateTime date) {
    return _sDay.isBefore(date) && date.isBefore(_dDay);
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

  SessionData.fromJson(Map<String, dynamic> parsedJson) {
    _sessionInfo = SessionInfo.fromJson(parsedJson['sessionInfo']);

    _paymentListData = List<PaymentListPerDay>.generate(
        parsedJson['paymentListData'].length,
        (index) =>
            PaymentListPerDay.fromJson(parsedJson['paymentListData'][index]));
  }

  SessionInfo get sessionInfo => _sessionInfo;
  List<PaymentListPerDay> get paymentListData => _paymentListData;
}

class DataModel {
  late List<SessionData> _sessionList = List<SessionData>.empty();

  DataModel();

  DataModel.fromJson(Map<String, dynamic> parsedJson) {
    parsedJson['data'].forEach((element) {
      _sessionList.add(SessionData.fromJson(element));
    });
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

class DataRepository {
  late DataModel _data;
  bool _isLoaded = false;

  DataRepository() {
    loadData();
  }

  Future<DataModel?> loadData() async {
    Map<String, dynamic> parsedJson = await loadLocalData();

    if (parsedJson['data'] != null) {
      _data = DataModel.fromJson(parsedJson);
    } else {
      _data = DataModel();
    }

    _isLoaded = true;
    return _data;
  }

  DataModel? get data => _isLoaded ? _data : null;
  bool get isLoaded => _isLoaded;

  void saveData() async {
    await saveLocalDataFromObject(_data);
  }

  void addNewSession(SessionInfo sessionInfo) {
    _data.allSessions.insert(0, SessionData(sessionInfo: sessionInfo));
  }

  void editCurrentSessionInfo(
      {int? budget, int? totalUse, DateTime? sDay, DateTime? dDay}) {
    var si = _data.currentSession._sessionInfo;
    si._budget = budget != null ? budget : si._budget;
    si._totalUse = totalUse != null ? totalUse : si._totalUse;
    si._sDay = sDay != null ? sDay : si._sDay;
    si._dDay = dDay != null ? dDay : si._dDay;
  }

  void addPaymentInfo(DateTime currentDate, PaymentInfo paymentInfo) {}

  void removePaymentInfo() {}
}
