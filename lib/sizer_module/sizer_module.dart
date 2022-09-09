import 'dart:io';

import 'package:flutter/material.dart';

class SizerModule {
  static late Orientation orientation;
  static late Type deviceType = Type.OTHER;


   /// with [defaultScreenHeight] and [defaultScreenWidth]
  ///  based on designed phone size
  static late double defaultScreenHeight = 834;
  static late double defaultScreenWidth = 376;


  /// Device's width
  static late double width;
  /// Device's height
  static late double height;


  ///  default size [width] or [height] == null
  /// follow setting file design
  static void setDefaultScreenSize(
      {required double width, required double height}) {
    defaultScreenHeight = width;
    defaultScreenWidth = height;
  }

    /// setup screen size
    /// size screen => physical, no set from pixel
    /// OrientationBuilder define LANDSCAPE or PORTRAIT
  static void setSizeScreen(Size size, Orientation orientation) {
    width = size.width;
    height = size.height;

    debugPrint("width: $width -- height: $height -- orientation: $deviceType");
    if (Platform.isAndroid || Platform.isIOS) {

      if (orientation == Orientation.portrait && height > width) {
        deviceType = Type.PORTRAIT;
      } else if (orientation == Orientation.landscape && width > height) {
        deviceType = Type.LANDSCAPE;
      } else {
        deviceType = Type.OTHER;
      }
    } else {
      deviceType = Type.OTHER;
    }
  }
}

extension SizerExt on num {
  double get h => (this * 100 / SizerModule.defaultScreenHeight) * SizerModule.height / 100;

  double get w => (this * 100 / SizerModule.defaultScreenWidth)  *  SizerModule.width / 100;

  /// Calculates the sp depending on the device's screen size
  double get sp => this * (SizerModule.width / 3) / 100;
}

enum Type { LANDSCAPE, PORTRAIT, OTHER }
