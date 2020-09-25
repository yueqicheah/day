import 'package:flutter/material.dart';
import 'package:login/loading.dart';
import 'package:login/screens/authenticate/splash_button.dart';
import 'package:login/services/auth.dart';
import 'package:login/constants.dart';
import 'package:login/screens/authenticate/signin.dart';

class Register extends StatefulWidget {
  static const String id = 'register';
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validatePassword(String value) {
    Pattern pattern = r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  final _titleTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passTextController2 = TextEditingController();
  bool _isHidden = true;
  bool loading = false;
  //text field state
  String email = '';
  String password = '';

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              //resizeToAvoidBottomPadding: false,
              backgroundColor: Colors.white,
              body: Container(
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [Color(0xFFe4f4fc), Color(0xFFFFFFFF)],
                //     stops: [0, 0.9],
                //   ),
                // ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Spacer(),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Register',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Text(
                                  'Register with email and password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: kPrimaryLightColor,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: kTextFieldDecoration,
                                child: TextField(
                                  controller: _titleTextController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.email),
                                    hintText: 'Email',
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: kTextFieldDecoration,
                                child: TextField(
                                  controller: _passTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      onPressed: _toggleVisibility,
                                      icon: _isHidden
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  obscureText: _isHidden ? true : false,
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: kTextFieldDecoration,
                                child: TextField(
                                  controller: _passTextController2,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: 'Retype password',
                                    suffixIcon: IconButton(
                                      onPressed: _toggleVisibility,
                                      icon: _isHidden
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  obscureText: _isHidden ? true : false,
                                  onChanged: (value) {
                                    if (value == password) {
                                      setState(() {
                                        password = value;
                                      });
                                    } else {
                                      print('password does not match');
                                    }
                                  },
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: <Widget>[
                            Spacer(),
                            Builder(builder: (BuildContext context) {
                              return DefaultButton(
                                text: 'Register',
                                press: () async {
                                  String email = _titleTextController.text;
                                  String password = _passTextController.text;
                                  String password2 = _passTextController2.text;
                                  if (isInputValid(
                                      email, password, password2)) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            'Account registered successfully!')));
                                    Future.delayed(
                                        const Duration(milliseconds: 1000), () {
                                      setState(() {
                                        loading =
                                            true; // Here you can write your code for open new view
                                      });
                                    });
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  } else {
                                    showError(
                                        context, email, password, password2);
                                  }
                                },
                                colour: kPrimaryLightColor,
                              );
                            }),
                            kBar,
                            DefaultButton(
                              text: 'Log In',
                              press: () {
                                Navigator.popAndPushNamed(context, SignIn.id);
                              },
                              colour: kPrimaryColor,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  bool isInputValid(String email, String password, String password2) {
    return (email.isNotEmpty && password.isNotEmpty && password2.isNotEmpty) &&
        (password == password2) &&
        (validateEmail(email)) &&
        (validatePassword(password) && (validatePassword(password2)));
  }

  void showError(
      BuildContext context, String email, String password, String password2) {
    showSnackBar(context,
        'A valid email address and alphanumeric password with at least 6 characters is required.');
  }

  void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
