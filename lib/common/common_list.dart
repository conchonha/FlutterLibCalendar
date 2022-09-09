import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/common/common_action.dart';
import 'package:flutter_lib_calendar/common/common_data.dart';
import 'package:flutter_lib_calendar/resource/app_color.dart';
import 'package:flutter_lib_calendar/resource/app_style.dart';

import '../resource/app_dimens.dart';

class CommonListItem<T extends CommonData> extends StatelessWidget {
  T commonData;
  CommonAction<T> iAction;
  late final BuildContext context;

  CommonListItem({Key? key, required this.commonData, required this.iAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return InkWell(
      onTap: () {
        iAction.onCheckedListener(commonData);
      },
      onLongPress: () {
        iAction.onLongClickListener(commonData);
      },
      child: _getWidgetType,
    );
  }

  Widget get _getWidgetType {
    switch (commonData.dataType) {
      case DataType.TYPE_LIST_ARROW_PREVIEW:
        return _typeListArrowPreview;
      case DataType.TYPE_CHECKBOX:
        return _typeCheckBox;
      default:
        return const SizedBox.shrink();
    }
  }

  Widget get _typeListArrowPreview => Row(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: AppDP.dp_5,
        height: AppDP.dp_5,
        margin: const EdgeInsets.only(right: AppDP.dp_5,top: AppDP.dp_7,bottom: AppDP.dp_7),
        decoration: BoxDecoration(
            color: commonData.leadingColor, shape: BoxShape.circle),
      ),
      autoTextSize(commonData.title,
          textAlign: TextAlign.start,
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColor.h00cccc,
          ))
    ],
  );

  Widget get _typeCheckBox => Row(
    children: [
      Container(
          width: AppDP.dp_4,
          height: AppDP.dp_4,
          margin: const EdgeInsets.symmetric(horizontal: AppDP.dp_4,vertical: AppDP.dp_7),
          child: Transform.scale(
            scale: 0.4,
            child: Checkbox(
              onChanged: (value){
                commonData.isChecked = value!;
                iAction.onCheckedListener(commonData);
              },
              value: commonData.isChecked,
            ),
          )),
      Expanded(child: autoTextSize(" ${commonData.title}",
          textAlign: TextAlign.start,
          textStyle: Theme.of(context)
              .textTheme
              .bodySmall)),
    ],
  );
}



