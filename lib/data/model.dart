import 'package:cash_analyzer/data/model/sessionData.dart';
import 'package:cash_analyzer/data/model/settings.dart';
import 'package:cash_analyzer/utils/time.dart';

import 'model/sessionInfo.dart';

export 'package:cash_analyzer/data/model/settings.dart';
export 'package:cash_analyzer/data/model/sessionData.dart';
export 'package:cash_analyzer/data/model/sessionInfo.dart';
export 'package:cash_analyzer/data/model/paymentInfo.dart';

class DataModel {
  late List<SessionData> _sessionList;
  late Settings _settings;

  DataModel() : _sessionList = List<SessionData>.empty();

  DataModel.fromJson(Map<String, dynamic> jsonData)
      : _sessionList = List<SessionData>.generate(jsonData['data'].length,
            (index) => SessionData.fromJson(jsonData['data'][index])),
        _settings = Settings.fromJson(jsonData['settings']);

  Map<String, dynamic> toJson() =>
      {'data': _sessionList, 'settings': _settings};

  List<SessionData> get allSessions => _sessionList;
  SessionData get currentSession {
    if (_sessionList[0].sessionInfo.isContain(DateTime.now())) {
      return _sessionList[0];
    } else {
      _addNewSession();
      return _sessionList[0];
    }
  }

  void _addNewSession() {
    DateTime tempDate = removeTime(DateTime.now());
    tempDate.subtract(Duration(days: tempDate.day - 1));

    SessionInfo sessionInfo =
        SessionInfo(budget: _settings.nextBudget, sDay: tempDate);

    allSessions.insert(0, SessionData(sessionInfo));
  }

  Settings get settings => _settings;

  SessionData? findSession(DateTime date) {
    DateTime dateOnly = removeTime(date);
    for (int i = 0; i < _sessionList.length; i++) {
      SessionData session = _sessionList[i];
      if (session.sessionInfo.isContain(dateOnly.add(Duration(seconds: 1)))) {
        return session;
      }
    }
  }
}
