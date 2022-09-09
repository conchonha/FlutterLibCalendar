import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_lib_calendar/resource/app_dimens.dart';

import '../../../main.dart';

typedef void OnWidgetSizeChange(Size? size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (ct, or) {
        SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
        return Container(
          key: widgetKey,
          child: widget.child,
        );
      },
    );
  }

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    var newSize = context?.size ?? const Size(AppDP.dp_0, AppDP.dp_0);
    widget.onChange(newSize);
  }
}
