import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime removeTime(DateTime date) {
  return DateTime.parse(DateFormat("yyyy-MM-dd").format(date));
}

DateTime changeTime(DateTime date, TimeOfDay time) {
  return removeTime(date).add(Duration(hours: time.hour, minutes: time.minute));
}
