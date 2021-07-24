import 'dart:io';
import 'dart:convert';
import 'package:cash_analyzer/app/index.dart';
import 'package:path_provider/path_provider.dart';

// flutter 2.13.0 or above
// typedef Json = Map<String, dynamic>;

Map<String, dynamic> saveDataList = {
  'data': [
    {
      'sessionInfo': {
        'budget': 300000,
        'totalUse': 30000,
        'sDay': '2021-07-02T00:00:00.000',
        'dDay': '2021-08-01T00:00:00.000'
      },
      'paymentListData': {
        '2021-07-16T00:00:00.000': [
          {
            'title': '점심',
            'desc': '버거킹 몬스터와퍼 세트',
            'time': '2021-07-16T17:32:14.223',
            'price': 9000,
            'tags': ['food']
          },
          {
            'title': '택시비',
            'desc': '버스 터미널 가는 택시비',
            'time': '2021-07-16T18:04:56.429',
            'price': 6000,
            'tags': ['transfer']
          },
          {
            'title': '버스비',
            'desc': '집가는 시외버스 티켓',
            'time': '2021-07-16T18:21:22.556',
            'price': 15000,
            'tags': ['transfer']
          }
        ]
      }
    }
  ],
  // TODO: add setting data
  // 'setting' {
  //   ''
  // },
};

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/analysData.txt');
}

Future<Map<String, dynamic>> createFile() async {
  final file = await _localFile;
  file.create();
  file.writeAsString(jsonEncode(saveDataList));
  return saveDataList;
}

Future<Map<String, dynamic>?> loadLocalData() async {
  try {
    final file = await _localFile;

    // 파일 읽기.
    String contents = await file.readAsString();

    final _data = jsonDecode(contents);

    return _data;
  } catch (e, s) {
    print("error in loadLocalData=============");
    print(e);
    print(s);
    print("===================================");
    return null;
  }
}

Future<File?> saveLocalDataFromParsedJson(Map<String, dynamic> data) async {
  try {
    print(jsonEncode(data));
    final file = await _localFile;

    // 파일 쓰기
    return file.writeAsString(jsonEncode(data), flush: true);
  } catch (e) {
    print("error in saveLocalDataFromParsedJson");
  }
}

Future<File?> saveLocalDataFromObject(Object data) async {
  try {
    print(jsonEncode(data));
    final file = await _localFile;

    // 파일 쓰기
    return file.writeAsString(jsonEncode(data), flush: true);
  } catch (e) {
    print("error in saveLocalDataFromObject");
  }
}

//jsonData 형식
//{
//   "data" :
// [
//   {}
// ]
// 데이터 리스트에 Json 형식으로 고정하는 형태
//}
