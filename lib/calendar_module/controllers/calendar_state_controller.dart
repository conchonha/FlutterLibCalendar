import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../calendar_event.dart';
import '../date_extension.dart';

/// Controller to call functions from argument like [onPageChanged] and [onCellTapped]
class CalendarStateController extends ChangeNotifier {
  CalendarStateController({
    required this.events,
  }) {
    _initialize();
  }

  final List<CalendarEvent> events;
  DateTime? currentDateTime;

  // check user chose DayCell on, _currentTimeOfPage save location user chose, when onPageChange will get value from hashmap
  int _index = -1;
  bool _checkTimeOfPage = true;
  final HashMap<int, DateTime?> _currentTimeOfPage = HashMap<int, DateTime>();

  //default index of page Calendar => 1200
  int _defaultIndex = initialPageIndex;

  //type filter [Year,Month,Date]
  ModeType _modeType = ModeType.MODE_MONTH;

  //set type filter [Year,Month,Date]
  void setModeType(ModeType modeType){
    _modeType = modeType;
  }

  //when type = Mode Date, screen will display all event of date, setCurrentDateTimeTypeDate will set value for currentDateTime
  void _setCurrentDateTimeTypeDate() {
    if (_index == _defaultIndex) {
      debugPrint("SangTB bawng: $_index");
      currentDateTime = DateTime.now();
    } else if (_index < _defaultIndex) {
      debugPrint("SangTB nho hon: $_index");
      _plushOrMinus(_index, false);
    } else {
      debugPrint("SangTB lon hon: $_index");
      _plushOrMinus(_index, true);
    }
  }

  //calculate base on index of Page => CurrentDateTime of Mode Day
  void _plushOrMinus(int index, bool plush) {
    _defaultIndex = index;
    var tmp = currentDateTime;
    var day = plush ? tmp!.day + 1 : tmp!.day - 1;
    currentDateTime = DateTime(tmp.year, tmp.month, day);
  }

  void _initialize() {
    currentDateTime = DateTime.now();

    _index = initialPageIndex;
    if (_checkTimeOfPage) {
      _currentTimeOfPage[_index] = currentDateTime;
      _checkTimeOfPage = false;
    }

    notifyListeners();
  }

  void onPageChanged(int index) {
    _index = index;
    if(_modeType == ModeType.MODE_MONTH){
      currentDateTime = _currentTimeOfPage[index] ?? index.visibleDateTime;
    }else{
      _setCurrentDateTimeTypeDate();
    }
    notifyListeners();
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
    _currentTimeOfPage[_index] = date;
    currentDateTime = date;
    notifyListeners();
  }
}

enum ModeType{
  MODE_MONTH,
  MODE_DAY,
  MODE_WEEK_DAY
}
