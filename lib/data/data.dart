import 'package:cash_analyzer/data/file.dart';
import 'package:cash_analyzer/data/model.dart';
import 'package:cash_analyzer/utils/time.dart';

class DataRepository {
  late DataModel _data;
  bool _whileLoading = false;
  bool _isLoaded = false;

  DataRepository() {
    loadData();
  }

  Future<DataModel> loadData() async {
    if (!_isLoaded) {
      _whileLoading = true;

      Map<String, dynamic>? parsedJson = await loadLocalData();
      if (parsedJson != null) {
        _data = DataModel.fromJson(parsedJson);
      } else {
        _data = DataModel.fromJson(await createFile());
      }

      // _data = DataModel.fromJson(saveDataList);
      
      if (_data.currentSession.findDate(DateTime.now()) == null) {
        _data.currentSession
            .paymentListData[removeTime(DateTime.now()).toIso8601String()] = <PaymentInfo>[];
      }

      _isLoaded = true;
      _whileLoading = false;
    }
    return _data;
  }

  DataModel? get data => _isLoaded ? _data : null;
  bool get isLoaded => _isLoaded;
  bool get whileLoading => _whileLoading;

  Future<bool> saveData() async {
    // return await saveLocalDataFromObject(_data) != null;
    return true;
  }
}
