import 'package:cash_analyzer/data/model/sessionData.dart';
import 'package:cash_analyzer/utils/time.dart';

export 'package:cash_analyzer/data/model/sessionData.dart';
export 'package:cash_analyzer/data/model/sessionInfo.dart';
export 'package:cash_analyzer/data/model/paymentInfo.dart';

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
      if (session.sessionInfo.isContain(dateOnly.add(Duration(seconds: 1)))) {
        return session;
      }
    }
  }
}
