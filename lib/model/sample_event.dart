import 'package:flutter_lib_calendar/resource/app_color.dart';

import '../calendar_module/calendar_event.dart';

final listDropDow = ["Calendar", "Calendar1", "Calendar2", "Calendar3"];
final listFilter = [
  "Month",
  "Year",
  "Day"
];

List<CalendarEvent> sampleEvents() {
  final today = DateTime.now();
  final sampleEvents = [
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: -42)),
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: -30)),
        eventBackgroundColor: AppColor.hcc0000),
    CalendarEvent(
        eventName: "11111",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "11111",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColor.hcc0000),
    CalendarEvent(
        eventName: "11111",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "11111",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColor.hcc0000),
    CalendarEvent(
        eventName: "1111",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColor.hcc0000),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today,
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: AppColor.hcc0000),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: 7)),
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "SangTBh",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: AppColor.hcc0000),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(
          Duration(days: 13),
        ),
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: AppColor.hcc0000),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: 21)),
        eventBackgroundColor: AppColor.hcc0000),
    CalendarEvent(
        eventName: "SangTBp",
        eventDate: today.add(
          Duration(days: 30),
        ),
        eventBackgroundColor: AppColor.h00cccc),
    CalendarEvent(
        eventName: "SangTB",
        eventDate: today.add(Duration(days: 42)),
        eventBackgroundColor: AppColor.hcc0000),
  ];
  return sampleEvents;
}


