import 'package:flutter/material.dart';
import 'package:login/constants.dart';

class HomeModel extends StatefulWidget {
  int pageNumber;
  HomeModel({this.pageNumber});

  @override
  _HomeModelState createState() => _HomeModelState();
}

class _HomeModelState extends State<HomeModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            '${widget.pageNumber}',
            style: TextStyle(
              color: kTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
