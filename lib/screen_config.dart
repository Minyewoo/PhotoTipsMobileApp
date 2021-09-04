import 'package:flutter/widgets.dart';

class ScreenConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) => (inputHeight / 640.0) * ScreenConfig.screenHeight;
double getProportionateScreenWidth(double inputWidth) => (inputWidth / 360.0) * ScreenConfig.screenWidth;