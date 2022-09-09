import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../calendar_event.dart';
import '../date_extension.dart';

/// Controller to call functions from argument like [onPageChanged] and [onCellTapped]
class CalendarStateController extends ChangeNotifier {
  CalendarStateController({
    required this.events,
    required this.onPageChangedFromUserArgument,
  }) {
    this._initialize();
  }
  final List<CalendarEvent> events;
  DateTime? currentDateTime;

  int _index = -1;
  bool _checkTimeOfPage = true;
  final HashMap<int,DateTime?> currentTimeOfPage = HashMap<int,DateTime>();

  final Function(DateTime firstDate, DateTime lastDate)?
      onPageChangedFromUserArgument;

  void setIndex(int index){
    _index = index;
    if(_checkTimeOfPage){
      currentTimeOfPage[_index] = currentDateTime;
      _checkTimeOfPage = false;
    }
  }

  void _initialize() {
    currentDateTime = DateTime.now();
    notifyListeners();
  }

  void onPageChanged(int index) {
    currentDateTime = currentTimeOfPage[index] ?? index.visibleDateTime;

    if (onPageChangedFromUserArgument != null) {
      final currentFirstDate = _getFirstDay(currentDateTime!);
      onPageChangedFromUserArgument!(
          currentFirstDate, currentFirstDate.add(Duration(days: 41)));
    }
    notifyListeners();
  }

  DateTime _getFirstDay(DateTime dateTime) {
    final firstDayOfTheMonth = DateTime(dateTime.year, dateTime.month, 1);
    return firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDuration);
  }

  List<CalendarEvent> eventsOnTheDay(DateTime date) {
    final res = events
        .where((event) =>
            event.eventDate.year == date.year &&
            event.eventDate.month == date.month &&
            event.eventDate.day == date.day)
        .toList();
    return res;
  }

  void onCellTapped(DateTime date) {
    currentTimeOfPage[_index] = date;
    currentDateTime = date;
    notifyListeners();
  }
}
