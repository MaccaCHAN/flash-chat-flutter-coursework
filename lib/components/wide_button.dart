import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {

  final Color backgroundColor;
  final String title;
  final Function onPressed;

  WideButton({@required this.onPressed,@required  this.title,@required  this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed:
            // Navigator.pushNamed(context,screenId);
            onPressed
          ,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}