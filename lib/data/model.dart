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
    if (_sessionList.isEmpty ||
        !_sessionList[0].sessionInfo.isContain(DateTime.now())) {
      _addNewSession();
    }
    return _sessionList[0];
  }

  void _addNewSession() {
    allSessions.insert(
        0, SessionData(SessionInfo(budget: _settings.nextBudget)));
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
