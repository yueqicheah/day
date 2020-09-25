import 'package:flutter/material.dart';
import 'package:login/screens/authenticate/signin.dart';
import 'package:login/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:login/model/user.dart';
import 'package:login/screens/authenticate/register.dart';

class Wrapper extends StatelessWidget {
  static const String id = 'wrapper_screen';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
