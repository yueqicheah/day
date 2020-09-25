import 'package:flutter/material.dart';
import 'package:login/model/user.dart';
import 'package:login/screens/wrapper.dart';
import 'package:login/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/screens/authenticate/splash_screen.dart';
import 'package:login/screens/authenticate/signin.dart';
import 'package:login/screens/authenticate/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Muli',
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Color(0xFF757575)),
              bodyText2: TextStyle(color: Color(0xFF757575)),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: Splash.id,
        routes: {
          Splash.id: (context) => Splash(),
          Wrapper.id: (context) => Wrapper(),
          SignIn.id: (context) => SignIn(),
          Register.id: (context) => Register(),
        },
      ),
    );
  }
}
