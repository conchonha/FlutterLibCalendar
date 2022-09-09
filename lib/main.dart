import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/model/sample_event.dart';
import 'package:flutter_lib_calendar/resource/app_color.dart';
import 'package:flutter_lib_calendar/resource/app_dimens.dart';
import 'package:flutter_lib_calendar/ui/calendar_page.dart';
import 'package:flutter_lib_calendar/ui/widget/left_calendar_page.dart';
import 'package:flutter_lib_calendar/ui/widget/header_planning.dart';
import 'package:flutter_lib_calendar/viewmodel/calendar_viewmodel.dart';
import 'package:provider/provider.dart';

import 'calendar_module/controllers/calendar_state_controller.dart';
import 'calendar_module/controllers/cell_height_controller.dart';

void main() {
  runApp(MyApp());
}

final widgetKeyMain = GlobalKey();
final _sampleEvents = sampleEvents();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: widgetKeyMain,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            bodySmall: TextStyle(
                color: Colors.grey,
                fontSize: AppSP.sp_10,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w400),
            titleLarge: TextStyle(
              fontSize: AppSP.sp_12,
              fontWeight: FontWeight.bold,
              color: AppColor.h00cccc,
              overflow: TextOverflow.ellipsis,
            ),
          )),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CalendarStateController(
              events: sampleEvents(),
              onPageChangedFromUserArgument: null,
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => CellHeightController(),
          ),
          ChangeNotifierProvider(
            create: (_) => CalendarViewModel(),
          )
        ],
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Column(
          children: [
            HeaderPlanning(
              listDropCalendar: (valueChange) {
                //todo something
                return listDropDow;
              },
              listDropFilter: (valueChange) {
                //todo something
                return listFilter;
              },
              onChangeSearch: (value) {},
            ),
            Expanded(
                child: Row(
              children: [
                Flexible(fit: FlexFit.tight, flex: 2, child: LeftEventWidget()),
                const Flexible(flex: 8, child: CalendarPage())
              ],
            ))
          ],
        ),
      ),
    );
  }
}
