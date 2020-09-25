import 'package:flutter/material.dart';

final kTextFieldDecoration = BoxDecoration(
  color: Color(0xFFfcfbfc),
  borderRadius: BorderRadius.circular(100.0),
  boxShadow: [
    BoxShadow(
      color: Colors.white.withOpacity(0.7),
      offset: Offset(-3, -3),
      blurRadius: 5,
      spreadRadius: 3,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: Offset(3, 3),
      blurRadius: 5,
      spreadRadius: 3,
    ),
  ],
);

final kBar = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    SizedBox(
      child: Divider(
        color: Colors.grey[500],
      ),
      height: 5,
      width: 80,
    ),
    Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'OR',
        style: TextStyle(color: kTextColor),
      ),
    ),
    SizedBox(
      child: Divider(
        color: Colors.grey[500],
      ),
      height: 5,
      width: 80,
    ),
  ],
);

class SizeConfig {
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

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// const kPrimaryColor = Color(0xFFd59ffc);
// const kPrimaryLightColor = Color(0xFFe4b9fc);
const kPrimaryColor = Colors.blueGrey;
final kPrimaryLightColor = Colors.blueGrey[200];
// const kSecondaryColor = Colors.blueGrey;
// final kSecondaryLightColor = Colors.blueGrey[200];
const kTextColor = Color(0xFF757575);
const kAnimationDuration = Duration(milliseconds: 200);
