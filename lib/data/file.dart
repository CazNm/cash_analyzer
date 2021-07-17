import 'dart:io';
import 'dart:convert';
import 'package:cash_analyzer/app/index.dart';
import 'package:path_provider/path_provider.dart';

List<dynamic> saveDataList = [
  {"title": "test", "kinds": "food", "krw": "2000", "date": "2021-07-16"},
];

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/analysData.txt');
}

Future<Map<String, dynamic>> loadLocalData() async {
  try {
    final file = await _localFile;

    // 파일 읽기.
    String contents = await file.readAsString();

    final _data = jsonDecode(contents);

    print(_data);
    return _data;
  } catch (e) {
    // 에러가 발생할 경우 0을 반환.
    return {"data": "there is no data"};
  }
}

Future<File> saveLocalData(Map<String, dynamic> data) async {
  print(jsonEncode(data));
  final file = await _localFile;

  // 파일 쓰기
  return file.writeAsString(jsonEncode(data));
}

//jsonData 형식
//{
//   "data" :
// [
//   {}
// ]
// 데이터 리스트에 Json 형식으로 고정하는 형태
//}
