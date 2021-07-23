import 'package:cash_analyzer/data/file.dart';
import 'package:cash_analyzer/data/model.dart';

// TODO: all class must be null safty


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
    return await saveLocalDataFromObject(_data) != null;
  }

  Future<bool> addNewSession(SessionInfo sessionInfo) async {
    _data.allSessions.insert(0, SessionData(sessionInfo: sessionInfo));
    return await saveData();
  }

  // TODO: add validation
  Future<bool> editCurrentSessionInfo(
      {int? budget, int? totalUse, DateTime? sDay, DateTime? dDay}) async {
    SessionInfo si = _data.currentSession.sessionInfo;

    si.budget = budget != null ? budget : si.budget;
    si.totalUse = totalUse != null ? totalUse : si.totalUse;
    si.sDay = sDay != null ? sDay : si.sDay;
    si.dDay = dDay != null ? dDay : si.dDay;

    return await saveData();
  }

  Future<bool> addPaymentInfo(
      DateTime currentDate, PaymentInfo paymentInfo) async {
    PaymentListPerDay? paymentList = _data.findDate(currentDate);
    if (paymentList != null) {
      paymentList.paymentInfoList.add(paymentInfo);
      return await saveData();
    } else {
      return false;
    }
  }

  Future<bool> removePaymentInfo(DateTime dateWithTime) async {
    PaymentListPerDay? paymentList = _data.findDate(dateWithTime);
    if (paymentList != null) {
      paymentList.paymentInfoList.removeWhere((element) => element.time == dateWithTime);
      return await saveData();
    } else {
      return false;
    }
  }
}