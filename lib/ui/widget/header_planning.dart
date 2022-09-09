import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/main.dart';
import 'package:flutter_lib_calendar/resource/app_dimens.dart';
import 'package:flutter_lib_calendar/resource/app_title.dart';
import 'package:flutter_lib_calendar/sizer_module/sizer_module.dart';
import 'package:flutter_lib_calendar/sizer_module/sizer_widget.dart';
import 'package:flutter_lib_calendar/utils/const.dart';

import '../../resource/app_color.dart';
import '../../resource/app_style.dart';

typedef listDropDown = List<String> Function(String? value);

class HeaderPlanning extends StatelessWidget {
  HeaderPlanning(
      {Key? key,
      required this.listDropCalendar,
      required this.listDropFilter,
      required this.onChangeSearch})
      : super(key: key);
  final listDropDown listDropCalendar;
  final listDropDown listDropFilter;
  final Function(String) onChangeSearch;

  final TextEditingController _textController = TextEditingController();
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                    child: _dropDowItem(AppTitle.VIEW, listDropCalendar)),
                SizedBox(
                    width: AppDP.dp_110,
                    child: _dropDowItem(AppTitle.FiLTER, listDropFilter))
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
                  controller: _textController,
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

  Widget _dropDowItem(String firstText, listDropDown listItem) => Row(
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
            value: listItem(null)[Constant.ZERO],
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
