import 'package:flutter/material.dart';

import '../calendar_module/cell_calendar.dart';
import '../calendar_module/controllers/cell_calendar_page_controller.dart';
import '../resource/app_dimens.dart';
import '../resource/app_style.dart';
import '../model/sample_event.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return Container(
      color: Colors.white,
      child: OrientationBuilder(
        builder: (context, orientation) => CellCalendar(
          cellCalendarPageController: cellCalendarPageController,
          events: _sampleEvents,
          daysOfTheWeekBuilder: (dayIndex) {
            final labels = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDP.dp_10),
              child: autoTextSize(
                labels[dayIndex],
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: AppSP.sp_11),
                textAlign: TextAlign.center,
              ),
            );
          },
          onPageChanged: (firstDate, lastDate) {
            /// Called when the page was changed
            /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
          },
        ),
      ),
    );
  }
}
