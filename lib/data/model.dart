import 'package:cash_analyzer/data/model/sessionData.dart';
import 'package:cash_analyzer/data/model/settings.dart';
import 'package:intl/intl.dart';

import 'model/sessionInfo.dart';

export 'package:cash_analyzer/data/model/settings.dart';
export 'package:cash_analyzer/data/model/sessionData.dart';
export 'package:cash_analyzer/data/model/sessionInfo.dart';
export 'package:cash_analyzer/data/model/paymentInfo.dart';

class DataModel {
  // List<SessionData> _sessionList;
  Map<String, SessionData> _sessions;
  Settings _settings;

  DataModel.fromJson(Map<String, dynamic> jsonData)
      : _settings = Settings.fromJson(jsonData['settings']),
        _sessions = {} {
    jsonData['data'].forEach((key, value) {
      _sessions[key] = SessionData.fromJson(value);
    });
  }

  Map<String, dynamic> toJson() => {'data': _sessions, 'settings': _settings};

  Map<String, SessionData> get allSessions => _sessions;
  SessionData get currentSession {
    String key = DateFormat("yyyy-MM").format(DateTime.now());
    if (!_sessions.containsKey(key)) {
      _sessions[key] = SessionData(SessionInfo(budget: _settings.nextBudget));
    }
    return _sessions[key]!;
  }

  Settings get settings => _settings;

  SessionData? findSession(DateTime date) {
    String key = DateFormat("yyyy-MM").format(date);
    return _sessions[key];
  }
}
