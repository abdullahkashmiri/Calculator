import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String btnTxt;
  final Color btnColor;
  final Color txtColor;
  final Function(String) onPressed;

  CalcButton(this.btnTxt, this.btnColor, this.txtColor, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () => onPressed(btnTxt),
        child: Text(
          btnTxt,
          style: TextStyle(fontSize: 30, color: txtColor),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: btnColor,
          padding: EdgeInsets.all(20),
          minimumSize: Size(90, 90),
        ),
      ),
    );
  }
}
