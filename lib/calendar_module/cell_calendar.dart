import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calendar_event.dart';
import 'components/days_of_the_week.dart';
import 'components/days_row/days_row.dart';
import 'components/month_year_label.dart';
import 'controllers/calendar_state_controller.dart';
import 'controllers/cell_calendar_page_controller.dart';
import 'date_extension.dart';

typedef daysBuilder = Widget Function(int dayIndex);


/// Calendar widget like a Google Calendar
///
/// Expected to be used in full screen
class CellCalendar extends StatelessWidget {
  CellCalendar({
    this.cellCalendarPageController,
    this.events = const [],
    this.onPageChanged,
    this.todayMarkColor = Colors.blue,
    this.todayTextColor = Colors.white,
    this.daysOfTheWeekBuilder,
  });

  final CellCalendarPageController? cellCalendarPageController;

  /// Builder to show days of the week labels
  ///
  /// 0 for Sunday, 6 for Saturday.
  /// By default, it returns English labels
  final daysBuilder? daysOfTheWeekBuilder;

  final List<CalendarEvent> events;
  final void Function(DateTime firstDate, DateTime lastDate)? onPageChanged;
  final Color todayMarkColor;
  final Color todayTextColor;

  @override
  Widget build(BuildContext context) {
    return _CalendarPageView(
      daysOfTheWeekBuilder,
      cellCalendarPageController,
    );
  }
}

/// Shows [MonthYearLabel] and PageView of [_CalendarPage]
class _CalendarPageView extends StatelessWidget {
  _CalendarPageView(
    this.daysOfTheWeekBuilder,
    this.cellCalendarPageController,
  );

  final daysBuilder? daysOfTheWeekBuilder;
  late  CellCalendarPageController? cellCalendarPageController;

  @override
  Widget build(BuildContext context) {
    final calendarStateControl = Provider.of<CalendarStateController>(context,listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MonthYearLabel(cellCalendarPageController ?? CellCalendarPageController()),
        Expanded(
          child: PageView.builder(
            controller: cellCalendarPageController ??= CellCalendarPageController(),
            itemBuilder: (context, index) {
              calendarStateControl.setIndex(index);
              return _CalendarPage(
                index.visibleDateTime,
                daysOfTheWeekBuilder,
              );
            },
            onPageChanged: (index) {
              Provider.of<CalendarStateController>(context, listen: false)
                  .onPageChanged(index);
            },
          ),
        ),
      ],
    );
  }
}

/// Page of [_CalendarPage]
///
/// Wrapped with [CalendarMonthController]
class _CalendarPage extends StatelessWidget {
  const _CalendarPage(
    this.visiblePageDate,
    this.daysOfTheWeekBuilder,
   {
    Key? key,
  }) : super(key: key);

  final DateTime visiblePageDate;
  final daysBuilder? daysOfTheWeekBuilder;

  List<DateTime> _getCurrentDays(DateTime dateTime) {
    final List<DateTime> result = [];
    final firstDay = _getFirstDay(dateTime);
    result.add(firstDay);
    for (int i = 0; i + 1 < 42; i++) {
      result.add(firstDay.add(Duration(days: i + 1)));
    }
    return result;
  }

  DateTime _getFirstDay(DateTime dateTime) {
    final firstDayOfTheMonth = DateTime(dateTime.year, dateTime.month, 1);
    return firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDuration);
  }

  @override
  Widget build(BuildContext context) {
    final days = _getCurrentDays(visiblePageDate);
    return LayoutBuilder(
      builder: (ct, bx) => OrientationBuilder(builder: (ct,or) => Column(
          children: [
            DaysOfTheWeek(daysOfTheWeekBuilder),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  6,
                  (index) {
                    return DaysRow(
                      dates: days.getRange(index * 7, (index + 1) * 7).toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
