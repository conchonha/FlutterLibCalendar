import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/main.dart';

autoTextSize(String lable,{ TextStyle? textStyle,TextAlign? textAlign = TextAlign.center}) => AutoSizeText(
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  minFontSize: 8,
  maxFontSize: 25,
  textAlign: textAlign,
  lable,
  style: textStyle,
);
