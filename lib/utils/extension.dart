import 'package:flutter_lib_calendar/calendar_module/date_extension.dart';

extension DateExtendionFormat on DateTime{
  String get getDatetime{
    final monthName = month.monthName;
    return "${weekday.dayName}, $day $monthName ${year.toString()}";
  }
}