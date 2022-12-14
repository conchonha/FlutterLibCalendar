import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/main.dart';
import 'package:flutter_lib_calendar/resource/app_dimens.dart';
import 'package:flutter_lib_calendar/resource/app_title.dart';
import 'package:flutter_lib_calendar/sizer_module/sizer_module.dart';
import 'package:flutter_lib_calendar/sizer_module/sizer_widget.dart';
import 'package:provider/provider.dart';

import '../../resource/app_color.dart';
import '../../resource/app_style.dart';
import '../../viewmodel/calendar_viewmodel.dart';

typedef listDropDown = List<String> Function(String? value);

class HeaderPlanning extends StatefulWidget {
  final listDropDown listDropCalendar;
  final listDropDown listDropFilter;
  final Function(String) onChangeSearch;

  const HeaderPlanning(
      {Key? key,
      required this.listDropCalendar,
      required this.listDropFilter,
      required this.onChangeSearch})
      : super(key: key);

  @override
  State<HeaderPlanning> createState() => _HeaderPlanningState();
}

class _HeaderPlanningState extends State<HeaderPlanning> {
  final globalKey = GlobalKey();
  late CalendarViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CalendarViewModel>(context, listen: true);

    return SizerUtils(
      key: globalKey,
      builder: (context, orientation, deviceType) => Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(color: Theme.of(context).dividerColor))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: AppDP.dp_110,
                    child: _dropDowItem(AppTitle.VIEW, widget.listDropCalendar,
                        viewModel.textDropCalendar)),
                SizedBox(
                    width: AppDP.dp_110,
                    child: _dropDowItem(AppTitle.FiLTER, widget.listDropFilter,
                        viewModel.textFilter))
              ],
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.all(AppDP.dp_5),
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: SizedBox(
                width: AppDP.dp_120.w,
                height: AppDP.dp_30,
                child: TextField(
                  autofocus: false,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.name,
                  style: Theme.of(widgetKeyMain.currentContext!)
                      .textTheme
                      .bodySmall,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: AppColor.h00cccc,
                        size: AppSP.sp_12,
                      ),
                      hintText: AppTitle.SEARCH,
                      fillColor: Colors.white.withAlpha(980),
                      filled: true,
                      enabledBorder: const UnderlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(AppDP.dp_0)),
                          borderSide: BorderSide(
                              color: Colors.transparent, width: AppDP.dp_0))),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _dropDowItem(
          String firstText, listDropDown listItem, String? textDrop) =>
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppDP.dp_5),
            child: autoTextSize(
              firstText,
              textStyle:
                  Theme.of(globalKey.currentContext!).textTheme.bodySmall,
            ),
          ),
          Expanded(
              child: DropdownButton<String>(
            alignment: Alignment.topRight,
            value: textDrop,
            icon: const Icon(
              Icons.arrow_drop_down,
              size: AppDP.dp_12,
              color: AppColor.h00cccc,
            ),
            items: listItem(null)
                .map((e) => DropdownMenuItem(
                      child: autoTextSize(e,
                          textStyle: Theme.of(globalKey.currentContext!)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: AppColor.h00cccc,
                                fontWeight: FontWeight.bold,
                              )),
                      value: e,
                    ))
                .toList(),
            onChanged: listItem,
            underline: const SizedBox.shrink(),
          )),
        ],
      );
}
