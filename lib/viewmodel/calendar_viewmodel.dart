import 'package:flutter/cupertino.dart';
import 'package:flutter_lib_calendar/calendar_module/calendar_event.dart';
import 'package:flutter_lib_calendar/common/common_action.dart';
import 'package:flutter_lib_calendar/model/doctor.dart';

class CalendarViewModel extends ChangeNotifier {
  final eventUpComing = const EventUpComing();
  final eventDoctor = const EventDoctorName();
  bool? changeNote = false;

  final listDoctor = [
    Doctor("Prof Charlotte Harper",isChecked: false),
    Doctor("Dr Evelyn Smith",isChecked: true),
    Doctor("Dr Ethan Lee",isChecked: false),
    Doctor("Dr Noah Green",isChecked: true),
    Doctor("Dr Oliver Twist",isChecked: true),
    Doctor("Dr Oscar Lim",isChecked: true),
    Doctor("Dr Ovatine Crusher",isChecked: true),
    Doctor("Dr Samuel Solomon",isChecked: true),
  ];

  void onCheckedNoteChange(bool? value){
    changeNote = value;
    notifyListeners();
  }
}

class EventUpComing extends CommonAction<CalendarEvent>{
  const EventUpComing();
}

class EventDoctorName extends CommonAction<Doctor>{
  const EventDoctorName();
}