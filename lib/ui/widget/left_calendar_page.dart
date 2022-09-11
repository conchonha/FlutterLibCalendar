import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/calendar_module/controllers/calendar_state_controller.dart';
import 'package:flutter_lib_calendar/common/common_list.dart';
import 'package:flutter_lib_calendar/main.dart';
import 'package:flutter_lib_calendar/model/doctor.dart';
import 'package:flutter_lib_calendar/resource/app_color.dart';
import 'package:flutter_lib_calendar/resource/app_dimens.dart';
import 'package:flutter_lib_calendar/resource/app_style.dart';
import 'package:flutter_lib_calendar/sizer_module/sizer_widget.dart';
import 'package:flutter_lib_calendar/utils/app_title.dart';
import 'package:flutter_lib_calendar/utils/const.dart';
import 'package:flutter_lib_calendar/viewmodel/calendar_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../calendar_module/calendar_event.dart';

class LeftEventWidget extends StatelessWidget {
  LeftEventWidget({Key? key}) : super(key: key);

  late CalendarStateController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<CalendarStateController>(context, listen: true);

    return SizerUtils(
      builder: (x, y, z) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDP.dp_6),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _button(onTap: () {
              /// todo something
            }),
            _titleOfList(Constant.UPCOMMING_TYPE),
            _titleOfList(Constant.DOCTOR_TYPE),
          ],
        ),
      ),
    );
  }

  Flexible _titleOfList(int type) {
    final checkType = type == Constant.UPCOMMING_TYPE;
    return  Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  flex: 6,
                  fit: FlexFit.tight,
                  child: autoTextSize(
                      checkType ? AppTitle.UPCOMING_EVENT : AppTitle.DOCTOR_NAME,
                      textAlign: TextAlign.start,
                      textStyle: Theme.of(widgetKeyMain.currentContext!)
                          .textTheme
                          .bodySmall)),
              Flexible(
                flex: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    checkType
                        ? const SizedBox.shrink()
                        : Container(
                      width: AppDP.dp_5,
                      height: AppDP.dp_5,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.h00cccc),
                    ),
                    Expanded(
                        child: Container(
                          width: double.infinity,
                          height: AppDP.dp_1,
                          color:
                          Theme.of(widgetKeyMain.currentContext!).dividerColor,
                        )),
                    Icon(
                      checkType
                          ? Icons.calendar_month_sharp
                          : Icons.arrow_drop_down_outlined,
                      color: AppColor.h00cccc,
                      size: AppDP.dp_10,
                    )
                  ],
                ),
              )
            ],
          ),
          Flexible(
            child: Consumer<CalendarViewModel>(
                builder: (context, vm, child) =>
                checkType ? _listUpComing(vm) : _listDoctor(vm)),
          ),
          checkType ? _note : const SizedBox.shrink()
        ],
      ),
    );
  }

  Padding _listDoctor(CalendarViewModel vm) => Padding(
        padding: const EdgeInsets.only(top: AppDP.dp_10),
        child: ListView(
          shrinkWrap: true,
          children: vm.listDoctor
              .map((e) => CommonListItem<Doctor>(
                  commonData: e, iAction: vm.eventDoctor))
              .toList(),
        ),
      );

  Container _listUpComing(CalendarViewModel vm) => Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: AppDP.dp_10),
        padding: const EdgeInsets.symmetric(
            horizontal: AppDP.dp_5, vertical: AppDP.dp_15),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: _controller
              .eventsOnTheDay(_controller.currentDateTime!)
              .map((e) => CommonListItem<CalendarEvent>(
              commonData: e, iAction: vm.eventUpComing))
              .toList(),
        ),
      );

  Widget get _note => Container(
        padding: const EdgeInsets.symmetric(vertical: AppDP.dp_10),
        child: Consumer<CalendarViewModel>(
          builder: (context, vm, _) => Row(
            children: [
              Container(
                  width: AppDP.dp_4,
                  height: AppDP.dp_4,
                  margin: const EdgeInsets.symmetric(horizontal: AppDP.dp_4),
                  child: Transform.scale(
                      scale: 0.6,
                      child: Checkbox(
                          value: vm.changeNote,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: vm.onCheckedNoteChange))),
              autoTextSize(AppTitle.NOTE,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColor.h00cccc)),
              Container(
                width: AppDP.dp_5,
                height: AppDP.dp_5,
                margin: const EdgeInsets.only(left: AppDP.dp_5),
                decoration: const BoxDecoration(
                    color: AppColor.hcc0000, shape: BoxShape.circle),
              )
            ],
          ),
        ),
      );

  Widget _button({required Function() onTap}) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: AppDP.dp_20,
          margin: const EdgeInsets.symmetric(vertical: AppDP.dp_10),
          decoration: const BoxDecoration(
              color: AppColor.h00cccc,
              borderRadius: BorderRadius.all(Radius.circular(AppDP.dp_4))),
          child: Center(
            child: autoTextSize(
              AppTitle.CREATE,
              textStyle: Theme.of(widgetKeyMain.currentContext!)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white, fontSize: AppSP.sp_10),
            ),
          ),
        ),
      );
}
