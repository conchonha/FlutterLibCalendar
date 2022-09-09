import 'package:flutter/cupertino.dart';
import 'package:flutter_lib_calendar/common/common_data.dart';

class CommonAction<T extends CommonData> implements IActionListener<T>{
  const CommonAction();

  @override
  void onCheckedListener(T data) {
    // TODO: implement onCheckedListener
  }

  @override
  void onClickListener(T data) {
    // TODO: implement onClickListener
  }

  @override
  void onLongClickListener(T data) {
    // TODO: implement onLongClickListener
  }

  @override
  void onNavigate(T data) {
    // TODO: implement onNavigate
  }

}

abstract class IActionListener<T extends CommonData>{
  void onClickListener(T data);
  void onLongClickListener(T data);
  void onCheckedListener(T data);
  void onNavigate(T data);
}