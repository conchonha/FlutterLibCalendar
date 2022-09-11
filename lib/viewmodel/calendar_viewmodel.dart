import 'package:flutter/cupertino.dart';
import 'package:flutter_lib_calendar/calendar_module/calendar_event.dart';
import 'package:flutter_lib_calendar/common/common_action.dart';
import 'package:flutter_lib_calendar/model/doctor.dart';

import '../model/sample_event.dart';
import '../utils/const.dart';

class CalendarViewModel extends ChangeNotifier {
  final eventUpComing = const EventUpComing();
  final eventDoctor = const EventDoctorName();

  bool? changeNote = false;
  String textDropCalendar = listDropDow[Constant.ZERO];
  String textFilter = listFilter[Constant.ZERO];

  set setTextFilter(String? value) {
    if (value != null) {
      textFilter = value;
      notifyListeners();
    }
  }

  set setTextDropCalendar(String? value) {
    if (value != null) {
      textDropCalendar = value;
      notifyListeners();
    }
  }

  final listDoctor = [
    Doctor("Prof Charlotte Harper", isChecked: false),
    Doctor("Dr Evelyn Smith", isChecked: true),
    Doctor("Dr Ethan Lee", isChecked: false),
    Doctor("Dr Noah Green", isChecked: true),
    Doctor("Dr Oliver Twist", isChecked: true),
    Doctor("Dr Oscar Lim", isChecked: true),
    Doctor("Dr Ovatine Crusher", isChecked: true),
    Doctor("Dr Samuel Solomon", isChecked: true),
  ];

  void onCheckedNoteChange(bool? value) {
    changeNote = value;
    notifyListeners();
  }
}

class EventUpComing extends CommonAction<CalendarEvent> {
  const EventUpComing();
}

class EventDoctorName extends CommonAction<Doctor> {
  const EventDoctorName();
}
