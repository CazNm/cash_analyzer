class SessionInfo {
  late int _budget;
  late int _totalUse;
  late DateTime _sDay;
  late DateTime _dDay;
  late bool _editable;

  SessionInfo(
      {required budget,
      totalUse = 0,
      required sDay,
      DateTime? dDay}) : _budget = budget,
      _totalUse = totalUse,
      _sDay = sDay,
      _editable = true {
    if (dDay == null) {
      _dDay = DateTime.parse('${sDay.year}-${sDay.month + 1}-${sDay.day}')
          .subtract(Duration(
              days: 1)); // TODO: change this value to reference config's value
    } else {
      _dDay = dDay;
    }
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
