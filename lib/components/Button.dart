import 'package:flutter/cupertino.dart';

class Button extends StatelessWidget {
  const Button({this.text, this.backgroundColor, this.textColor, this.onPress});

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Function onPress;

  Widget build(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        // todo handle press event
        onPress();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: backgroundColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            )
          ],
        ),
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      ),
    );
  }
}
