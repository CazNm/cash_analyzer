import 'package:cash_analyzer/data/file.dart';
import 'package:cash_analyzer/data/model.dart';

class DataRepository {
  late DataModel _data;
  bool _isLoaded = false;

  DataRepository() {
    loadData();
  }

  Future<DataModel?> loadData() async {
    Map<String, dynamic>? parsedJson = await loadLocalData();

    if (parsedJson != null) {
      _data = DataModel.fromJson(parsedJson);
      _isLoaded = true;
      return _data;
    }
  }

  DataModel? get data => _isLoaded ? _data : null;
  bool get isLoaded => _isLoaded;

  Future<bool> saveData() async {
    return await saveLocalDataFromObject(_data.toJson()) != null;
  }

  Future<bool> addNewSession(SessionInfo sessionInfo) async {
    _data.allSessions.insert(0, SessionData(sessionInfo));
    return await saveData();
  }

  // TODO: add validation
  Future<bool> editCurrentSessionInfo(
      {int? budget, int? totalUse, int? todayUse, DateTime? sDay, DateTime? dDay}) async {
    SessionInfo si = _data.currentSession.sessionInfo;

    si.budget = budget != null ? budget : si.budget;
    si.totalUse = totalUse != null ? totalUse : si.totalUse;
    si.todayUse = todayUse != null ? todayUse : si.todayUse;
    si.sDay = sDay != null ? sDay : si.sDay;
    si.dDay = dDay != null ? dDay : si.dDay;

    return await saveData();
  }

  Future<bool> addPaymentInfo(
      DateTime currentDate, PaymentInfo paymentInfo) async {
    List<PaymentInfo>? paymentList = _data.findSession(currentDate)!.findDate(currentDate);
    if (paymentList != null) {
      paymentList.add(paymentInfo);
      return await saveData();
    } else {
      return false;
    }
  }

  Future<bool> removePaymentInfo(DateTime currentDate) async {
    List<PaymentInfo>? paymentList = _data.findSession(currentDate)!.findDate(currentDate);
    if (paymentList != null) {
      paymentList.removeWhere((element) => element.time == currentDate);
      return await saveData();
    } else {
      return false;
    }
  }
}