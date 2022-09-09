import 'package:flutter_lib_calendar/common/common_data.dart';

class Doctor extends CommonData {
  Doctor(String doctorName, {required bool isChecked})
      : super(
            title: doctorName,
            isChecked: isChecked,
            dataType: DataType.TYPE_CHECKBOX);
}
