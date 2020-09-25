import 'package:flutter/material.dart';
import 'package:login/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.colour,
  }) : super(key: key);
  final String text;
  final Function press;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: press,
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 15),
          decoration: kTextFieldDecoration.copyWith(color: colour),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
