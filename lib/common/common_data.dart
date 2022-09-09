import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/resource/app_color.dart';

class CommonData {
  String title;
  String subTitle;
  DataType dataType;
  Color leadingColor;
  bool isChecked;

  CommonData(
      {this.title = "",
      this.subTitle = "",
      this.dataType = DataType.TYPE_LIST_ARROW_PREVIEW,
      this.leadingColor = AppColor.h00cccc,
      this.isChecked = false});
}

enum DataType { TYPE_LIST_ARROW_PREVIEW, TYPE_CHECKBOX }
