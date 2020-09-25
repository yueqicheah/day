import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:login/loading.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/authenticate/splash_button.dart';
import 'package:login/screens/home/home.dart';
import 'package:login/services/auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/constants.dart';
import 'package:login/screens/authenticate/register.dart';
import 'package:login/services/google.dart';

class SignIn extends StatefulWidget {
  static const String id = 'signin';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password does not match'),
    MinLengthValidator(6, errorText: 'Password does not match'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Password does not match')
  ]);
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

  bool isInputValid(String email, String password) {
    return (email.isNotEmpty && password.isNotEmpty) &&
        (validateEmail(email)) &&
        (validatePassword(password));
  }

  void showError(BuildContext context, String email, String password) {
    showSnackBar(context,
        'A valid email address and alphanumeric password with at least 6 characters is required.');
  }

  void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  final _titleTextController = TextEditingController();
  final _passTextController = TextEditingController();
  bool loading = false;
  bool _isHidden = true;

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
              resizeToAvoidBottomPadding: false,
              backgroundColor: Colors.white,
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: <Widget>[
                            Spacer(),
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: kPrimaryColor,
                              ),
                            ),
                            Text(
                              'Sign in with email and password or Continue with Google and Facebook',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: kPrimaryLightColor,
                              ),
                            ),
                            Spacer(
                              flex: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: kTextFieldDecoration.copyWith(
                                    color: Color(0xFFfcfbfc)),
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
                            Spacer(
                              flex: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: kTextFieldDecoration.copyWith(
                                    color: Color(0xFFfcfbfc)),
                                child: TextField(
                                  controller: _passTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: _toggleVisibility,
                                      icon: _isHidden
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    ),
                                    hintText: 'Password',
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
                            Spacer(
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: <Widget>[
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(15.0)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        signInWithGoogle().then((result) {
                                          if (result != null) {
                                            setState(() {
                                              loading =
                                                  true; // Here you can write your code for open new view
                                            });
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Home();
                                                },
                                              ),
                                            );
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: getProportionateScreenWidth(125),
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 15),
                                        decoration: kTextFieldDecoration
                                            .copyWith(color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                              image: AssetImage(
                                                  'images/google.png'),
                                              height: 28,
                                              width: 28,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Sign in with Google',
                                              style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        18),
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Builder(
                              builder: (BuildContext context) {
                                return DefaultButton(
                                  text: 'Login',
                                  colour: kPrimaryLightColor,
                                  press: () async {
                                    String email = _titleTextController.text;
                                    String password = _passTextController.text;
                                    if (isInputValid(email, password)) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text('Logging in...')));
                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        setState(() {
                                          loading =
                                              true; // Here you can write your code for open new view
                                        });
                                      });
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    } else {
                                      showError(context, email, password);
                                    }
                                  },
                                );
                              },
                            ),
                            kBar,
                            DefaultButton(
                              text: 'Register',
                              press: () {
                                Navigator.popAndPushNamed(context, Register.id);
                              },
                              colour: kPrimaryColor,
                            ),
                            Spacer(
                              flex: 2,
                            ),
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
}
