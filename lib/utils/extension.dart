import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/calendar_module/date_extension.dart';

extension DateExtendionFormat on DateTime{
  String get getDatetime{
    final monthName = month.monthName;
    return "${weekday.dayName}, $day $monthName ${year.toString()}";
  }
}

extension ColorExtension on Color{
  Color checkDateTime(DateTime dateTime, {Color? color,double? alpha}){
    DateTime today = DateTime.now();
    return dateTime.isBefore(today)? withOpacity(alpha ?? 0.2) : color ?? this;
  }
}