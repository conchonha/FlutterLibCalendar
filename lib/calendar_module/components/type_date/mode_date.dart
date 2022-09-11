import 'package:flutter/material.dart';
import 'package:flutter_lib_calendar/calendar_module/controllers/calendar_state_controller.dart';
import 'package:provider/provider.dart';

class ModeDate extends StatefulWidget {
  const ModeDate({Key? key}) : super(key: key);

  @override
  State<ModeDate> createState() => _ModeDateState();
}

class _ModeDateState extends State<ModeDate> {
  late CalendarStateController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<CalendarStateController>(context,listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.setCurrentDateTimeTypeDate();
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Center(child: Text("SangTB"),),
    );
  }
}
