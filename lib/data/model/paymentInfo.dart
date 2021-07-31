class PaymentInfo {
  late String _title;
  late DateTime _time;
  late int _price;

  PaymentInfo({
    required String title,
    required DateTime time,
    required int price,
  })  : _title = title,
        _time = time,
        _price = price;

  PaymentInfo.fromJson(Map<String, dynamic> jsonData)
      : _title = jsonData['title'],
        _time = DateTime.parse(jsonData['time']),
        _price = jsonData['price'];

  Map<String, dynamic> toJson() => {
        'title': _title,
        'time': _time.toIso8601String(),
        'price': _price,
      };

  String get title => _title;
  DateTime get time => _time;
  int get price => _price;
}
