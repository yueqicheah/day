import 'package:flutter/material.dart';
import 'package:login/constants.dart';
import 'package:login/screens/authenticate/splash_button.dart';
import 'package:login/screens/authenticate/splash_content.dart';
import 'package:login/screens/wrapper.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {'text': 'Welcome to Day!', 'image': 'images/list.png'},
    {'text': 'We help people to connect!', 'image': 'images/list2.png'},
    {'text': 'We arrange your task for you!', 'image': 'images/list3.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]['image'],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  Spacer(),
                  DefaultButton(
                    text: 'Log In',
                    press: () {
                      Navigator.popAndPushNamed(context, Wrapper.id);
                    },
                    colour: kPrimaryLightColor,
                  ),
                  Spacer(),
                  DefaultButton(
                    text: 'Sign Up',
                    press: () {
                      Navigator.popAndPushNamed(context, Wrapper.id);
                    },
                    colour: kPrimaryColor,
                  ),
                  Spacer(flex: 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
