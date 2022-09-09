import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/resource/app_color.dart';
import 'package:flutter_lib_calendar/resource/app_dimens.dart';
import 'package:flutter_lib_calendar/utils/const.dart';
import 'package:provider/provider.dart';

import '../../../resource/app_style.dart';
import '../../calendar_event.dart';
import '../../controllers/calendar_state_controller.dart';
import '../../controllers/cell_height_controller.dart';

/// Numbers to return accurate events in the cell.
const minHeightEvent = 100.0;
const minNumberEvent = 2;

/// Get events to be shown from [CalendarStateController]
///
/// Shows accurate number of [_EventLabel] by the height of the parent cell
/// notified from [CellHeightController]
class EventLabels extends StatelessWidget {
  EventLabels(this.date);

  final DateTime date;
  CellHeightController? provide;
  bool check = false;

  List<CalendarEvent> _eventsOnTheDay(
      DateTime date, List<CalendarEvent> events) {
    final res = events
        .where((event) =>
            event.eventDate.year == date.year &&
            event.eventDate.month == date.month &&
            event.eventDate.day == date.day)
        .toList();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    provide = Provider.of<CellHeightController>(context, listen: true);
    return Selector<CalendarStateController, List<CalendarEvent>>(
      builder: (context, events, _) {
        final eventsOnTheDay = _eventsOnTheDay(date, events);
        return Column(
          children: [
            _DayLabel(
              date: date,
            ),
            const SizedBox(
              height: AppDP.dp_4,
            ),
            ..._listEvent(eventsOnTheDay)
          ],
        );
      },
      selector: (context, controller) => controller.events,
    );
  }

  List<Widget> _listEvent(List<CalendarEvent> list) =>
      List.generate(_getLength(list), (index) {
        if (check) {
          if (index == minNumberEvent - Constant.ONE) {
            return const Flexible(
                flex: Constant.ONE,
                child: Center(
                  child: Icon(
                    Icons.more_horiz,
                    size: AppSP.sp_13,
                  ),
                ));
          }
        }
        return _eventLabel(list[index]);
      });

  int _getLength(List<CalendarEvent> list) {
    check = false;
    if (provide?.cellHeight == null || list.isEmpty) return Constant.ZERO;

    if (provide!.cellHeight! >= minHeightEvent) {
      return list.length;
    } else if (list.length > minNumberEvent) {
      check = true;
      return minNumberEvent;
    }
    return list.length;
  }

  /// label to show [CalendarEvent]
  Flexible _eventLabel(CalendarEvent event) {
    return Flexible(
        child: Container(
      height: AppDP.dp_13,
      margin: const EdgeInsets.only(
          bottom: AppDP.dp_1, left: AppDP.dp_4, right: AppDP.dp_4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDP.dp_6),
          ),
          color: AppColor.he0e0eb),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(left: AppDP.dp_5),
            alignment: Alignment.centerLeft,
            width: AppDP.dp_5,
            height: AppDP.dp_5,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: event.eventBackgroundColor),
          ),
          Expanded(
              child: autoTextSize(event.eventName,
                  textStyle: const TextStyle(
                      fontSize: AppSP.sp_11, color: AppColor.h00cccc)))
        ],
      ),
    ));
  }
}

class _DayLabel extends StatelessWidget {
  _DayLabel({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isCurrentDate = date.month == today.month &&
        date.day == today.day &&
        date.year == today.year;
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppDP.dp_4),
      child: autoTextSize(
          textAlign: TextAlign.start,
          date.day.toString(),
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isCurrentDate ? AppColor.h00cccc : Colors.grey,
                fontWeight: isCurrentDate? FontWeight.bold : FontWeight.w400
              )),
    );
  }
}
