import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:login/constants.dart';
import 'package:login/screens/authenticate/splash_screen.dart';
import 'package:login/services/auth.dart';
import 'package:login/services/google.dart';
import 'home2.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  PageController _pageController = PageController(
    initialPage: 2,
  );
  AnimationController _controller1;
  AnimationController _controller2;
  AnimationController _controller3;

  int currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(seconds: 1),
    );
    _controller2 = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(seconds: 1),
    );
    _controller3 = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            currentIndex = page;
          });
          currentIndex == 1 ? _controller1.forward() : _controller1.reverse();
          currentIndex == 2 ? _controller2.forward() : _controller2.reverse();
          currentIndex == 3 ? _controller3.forward() : _controller3.reverse();
        },
        children: <Widget>[
          HomeModel(
            pageNumber: 0,
          ),
          HomeModel(
            pageNumber: 1,
          ),
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
              signOutGoogle();
              Navigator.popAndPushNamed(context, Splash.id);
            },
            icon: Icon(Icons.person),
            label: Text('logout'),
          ),
          HomeModel(
            pageNumber: 3,
          ),
          HomeModel(
            pageNumber: 4,
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: kPrimaryLightColor,
        backgroundColor: Colors.white,
        buttonBackgroundColor: kPrimaryColor,
        items: <Widget>[
          Icon(
            Icons.chat_bubble_outline,
            size: 20,
            color: Colors.black,
          ),
          AnimatedIcon(
            icon: AnimatedIcons.list_view,
            progress: _controller1,
            size: 20,
            color: Colors.black,
          ),
          AnimatedIcon(
            icon: AnimatedIcons.add_event,
            progress: _controller2,
            size: 20,
            color: Colors.black,
          ),
          AnimatedIcon(
            icon: AnimatedIcons.search_ellipsis,
            progress: _controller3,
            size: 20,
            color: Colors.black,
          ),
          Icon(
            Icons.add,
            size: 20,
            color: Colors.black,
          ),
        ],
        onTap: (index) {
          index == 1 ? _controller1.forward() : _controller1.reverse();
          index == 2 ? _controller2.forward() : _controller2.reverse();
          index == 3 ? _controller3.forward() : _controller3.reverse();
          currentIndex = index;
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );
          setState(() {});
          print('$index');
        },
        animationDuration: kAnimationDuration,
        index: currentIndex,
      ),
    );
  }
}
