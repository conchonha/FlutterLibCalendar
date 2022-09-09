import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/resource/app_dimens.dart';
import 'package:flutter_lib_calendar/utils/app_title.dart';
import 'package:provider/provider.dart';

import '../../resource/app_style.dart';
import '../controllers/calendar_state_controller.dart';
import '../controllers/cell_calendar_page_controller.dart';
import 'package:flutter_lib_calendar/utils/extension.dart';

/// Label showing the date of current page
class MonthYearLabel extends StatelessWidget {
  const MonthYearLabel(
    this.cellCalendarPageController, {
    Key? key,
  }) : super(key: key);

  final CellCalendarPageController cellCalendarPageController;

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarStateController>(
      builder: (ct,model,child){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: BorderDirectional(start: BorderSide(color: Theme.of(context).dividerColor))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: AppDP.dp_10,
                    color: Colors.grey,
                  ),
                  autoTextSize(AppTitle.PREVIOUS,
                      textStyle: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppDP.dp_10),
                    child: autoTextSize(
                      model.currentDateTime!.getDatetime,
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  )),
              Row(
                children: [
                  autoTextSize(
                    AppTitle.NEXT,
                    textStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: AppDP.dp_11,
                    color: Colors.grey,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
