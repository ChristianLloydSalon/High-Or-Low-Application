import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final String fontFamily;

  final Color color;

  final double heightRatio;

  const CustomText({
    Key? key,
    required this.title,
    required this.fontFamily,
    required this.color,
    required this.heightRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * this.heightRatio,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          this.title,
          style: TextStyle(
            color: this.color,
            fontFamily: this.fontFamily,
          ),
        ),
      ),
    );
  }
}
