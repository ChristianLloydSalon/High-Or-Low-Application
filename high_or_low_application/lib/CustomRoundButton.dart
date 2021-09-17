import 'package:flutter/material.dart';

class CustomRoundButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final double ratio;
  final void Function() function;

  const CustomRoundButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.ratio,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late double boxSize;

    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;

    if (appHeight > appWidth) {
      boxSize = appWidth * ratio;
    } else {
      boxSize = appHeight * ratio;
    }

    return ClipOval(
      child: Material(
        color: this.color, // Button color
        child: InkWell(
          splashColor: Colors.red, // Splash color
          onTap: function,
          child: Container(
            width: boxSize,
            height: boxSize,
            child: FittedBox(
              child: this.icon,
            ),
          ),
        ),
      ),
    );
  }
}
