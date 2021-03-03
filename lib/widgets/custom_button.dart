import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  String text;
  Icon icon;
  Color color;
  Function onTap;
  CustomButton({this.text, this.icon, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      minWidth: double.maxFinite,
      height: 50,
      onPressed: () {
        if (onTap != null) {
          onTap();
        }
      },
      color: color != null ? color : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon != null ? icon : Icon(FontAwesomeIcons.sign),
          SizedBox(width: 10),
          Text(text,
              style: TextStyle(
                  color: color != Colors.white ? Colors.white : Colors.black,
                  fontSize: 16)),
        ],
      ),
      textColor: color != Colors.white ? Colors.white : Colors.black,
    );
  }
}
