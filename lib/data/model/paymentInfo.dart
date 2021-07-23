class PaymentInfo {
  late String _title;
  late String? _desc;
  late DateTime _time;
  late int _price;
  late List<String>? _tags;

  PaymentInfo(
      {required String title,
      String? desc,
      required DateTime time,
      required int price,
      List<String>? tags})
      : _title = title,
        _desc = desc,
        _time = time,
        _price = price,
        _tags = tags;

  PaymentInfo.fromJson(Map<String, dynamic> jsonData)
      : _title = jsonData['title'],
        _desc = jsonData['desc'],
        _time = DateTime.parse(jsonData['time']),
        _price = jsonData['price'],
        _tags = jsonData['tags'];

  Map<String, dynamic> toJson() => {
        'title': _title,
        'desc': _desc,
        'time': _time.toIso8601String(),
        'price': _price,
        'tags': _tags!,
      };

  String get title => _title;
  String? get desc => _desc;
  DateTime get time => _time;
  int get price => _price;
  List<String>? get tags => _tags;
}