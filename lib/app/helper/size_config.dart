import 'package:flutter/widgets.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double scaleFactorWidth = 0;
  static double screenHeight = 0;
  static double scaleFactorWidthHeight = 0;

  static void init(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if(orientation == Orientation.portrait){

      scaleFactorWidth =    screenWidth / 360;
      scaleFactorWidthHeight =    screenHeight / 640;

      print('Portrait--> Height:  ${screenHeight} Width:  ${screenWidth}');
      print('Portrait ${scaleFactorWidth}');
    }else{
      scaleFactorWidth = screenWidth / 640; //screenWidth / 360; // Adjust as needed based on your design
      scaleFactorWidthHeight =    screenHeight / 360;
      print('Landscape--> Height:  ${screenHeight} Width:  ${screenWidth}');
      print('Landscape ${scaleFactorWidth}');
    }

  }

  static double getScaledSize(double scaleSize) {
    return scaleSize * scaleFactorWidth;
  }

  static double getScaledFontSize(double baseFontSize) {
    return baseFontSize * scaleFactorWidth;
  }

  static double getIconSize(double iconSize) {
    // return screenWidth < 600 ? iconSize : 46; // Smaller on mobile, larger on desktop
    return iconSize * scaleFactorWidth;
  }

  static double getSize(double width) {
    return width * scaleFactorWidth;
  }

  static double getHeight(double height) {
    return height * scaleFactorWidthHeight;
  }
  
}
