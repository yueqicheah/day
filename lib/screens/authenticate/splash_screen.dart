import 'package:flutter/material.dart';
import 'package:login/constants.dart';
import 'package:login/screens/authenticate/splash_body.dart';

class Splash extends StatelessWidget {
  static const String id = 'splashscreen';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
