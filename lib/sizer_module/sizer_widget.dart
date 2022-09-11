import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/sizer_module/sizer_module.dart';

typedef BuilderSizer = Widget Function(
    BuildContext context,
    Orientation orientation,
    Type deviceType,
    );

class SizerUtils extends StatefulWidget {
  const SizerUtils({Key? key,required this.builder}) : super(key: key);
  final BuilderSizer builder;

  @override
  State<SizerUtils> createState() => _SizerUtilsState();
}

class _SizerUtilsState extends State<SizerUtils> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,boxConstraints)=>
      OrientationBuilder(builder: (context,orientation){
        SizerModule.setSizeScreen(MediaQuery.of(context).size, orientation);
        return widget.builder.call(context,orientation,SizerModule.deviceType);
      })
    );
  }
}
