import 'package:cash_analyzer/utils/time.dart';

class SessionInfo {
  late int _budget;
  late int _totalUse;
  late DateTime _sDay;
  late DateTime _dDay;
  late bool _editable;

  SessionInfo({required budget})
      : _budget = budget,
        _totalUse = 0,
        _editable = true {
    DateTime sDay = removeTime(DateTime.now());
    _sDay = sDay.subtract(Duration(days: sDay.day - 1));

    String month = (_sDay.month + 1).toString().padLeft(2, '0');
    _dDay = DateTime.parse('${_sDay.year}${month}01');
    _dDay = _dDay.subtract(Duration(days: 1));
  }

  SessionInfo.fromJson(Map<String, dynamic> jsonData)
      : _budget = jsonData['budget'],
        _totalUse = jsonData['totalUse'],
        _sDay = DateTime.parse(jsonData['sDay']),
        _dDay = DateTime.parse(jsonData['dDay']),
        _editable = jsonData['editable'];

  Map<String, dynamic> toJson() => {
        'budget': budget,
        'totalUse': totalUse,
        'sDay': sDay.toIso8601String(),
        'dDay': sDay.toIso8601String(),
        'editable': editable,
      };

  int get budget => _budget;
  int get totalUse => _totalUse;
  DateTime get sDay => _sDay;
  DateTime get dDay => _dDay;
  bool get editable => _editable;

  set budget(int budget) {
    if (_editable) {
      _budget = budget;
      _editable = false;
    }
  }

  void addTotalUse(int value) {
    _totalUse += value;
  }

  bool isContain(DateTime date) {
    return sDay.isBefore(date) && date.isBefore(dDay);
  }
}
