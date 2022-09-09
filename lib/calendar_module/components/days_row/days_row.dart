import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/resource/app_color.dart';
import 'package:flutter_lib_calendar/resource/app_dimens.dart';
import 'package:provider/provider.dart';

import '../../controllers/calendar_state_controller.dart';
import '../../controllers/cell_height_controller.dart';
import 'event_labels.dart';
import 'measure_size.dart';

/// Show the row of [_DayCell] cells with events
class DaysRow extends StatelessWidget {
  const DaysRow({
    required this.dates,
    Key? key,
  }) : super(key: key);

  final List<DateTime> dates;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: dates.map((date) {
          return _DayCell(
            date,
          );
        }).toList(),
      ),
    );
  }
}

/// Cell of calendar.
///
/// Its height is circulated by [MeasureSize] and notified by [CellHeightController]
class _DayCell extends StatelessWidget {
  _DayCell(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final provide = Provider.of<CalendarStateController>(context, listen: true);
    return Expanded(
        child: GestureDetector(
      onTap: () {
        provide.onCellTapped(date);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
                color: _checkDate(provide.currentDateTime)
                    ? AppColor.h00cccc
                    : Theme.of(context).dividerColor,
                width: AppDP.dp_0_7),
        ),
        child: MeasureSize(
          onChange: (size) {
            if (size == null) return;
            Provider.of<CellHeightController>(context, listen: false)
                .onChanged(size);
          },
          child: Column(
            children: [Expanded(child: EventLabels(date))],
          ),
        ),
      ),
    ));
  }

  bool _checkDate(DateTime? current) =>
      date.day == current?.day &&
      date.month == current?.month &&
      date.year == current?.year;
}
