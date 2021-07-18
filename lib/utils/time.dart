import 'package:intl/intl.dart';

DateTime removeTime(DateTime date) {
  String formattedDate = DateFormat("yyyy-MM-dd").format(date);
  return DateTime.parse(formattedDate);
}
