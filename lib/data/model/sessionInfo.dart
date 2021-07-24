class SessionInfo {
  late int budget;
  late int totalUse;
  late DateTime sDay;
  late DateTime dDay;

  SessionInfo(
      {required this.budget,
      this.totalUse = 0,
      required this.sDay,
      DateTime? dDay}) {
    if (dDay == null) {
      dDay = DateTime.parse(sDay.toString()).add(Duration(
          days: 30)); // TODO: change this value to reference config's value
    } else {
      dDay = dDay;
    }
  }

  SessionInfo.from(SessionInfo si,
      {int? budget,
      int? totalUse,
      DateTime? sDay,
      DateTime? dDay}) {
    this.budget = budget != null ? budget : si.budget;
    this.totalUse = totalUse != null ? totalUse : si.totalUse;
    this.sDay = sDay != null ? sDay : si.sDay;
    this.dDay = dDay != null ? dDay : si.dDay;
  }

  SessionInfo.fromJson(Map<String, dynamic> jsonData)
      : budget = jsonData['budget'],
        totalUse = jsonData['totalUse'],
        sDay = DateTime.parse(jsonData['sDay']),
        dDay = DateTime.parse(jsonData['dDay']);

  Map<String, dynamic> toJson() => {
        'budget': budget,
        'totalUse': totalUse,
        'sDay': sDay.toIso8601String(),
        'dDay': sDay.toIso8601String(),
      };

  void copyValue(SessionInfo si) {
    this.budget = si.budget;
    this.totalUse = si.totalUse;
    this.sDay = si.sDay;
    this.dDay = si.dDay;
  }

  bool isContain(DateTime date) {
    return sDay.isBefore(date) && date.isBefore(dDay);
  }
}
