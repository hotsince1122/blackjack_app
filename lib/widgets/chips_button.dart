import 'package:flutter/material.dart';

class ChipsButton extends StatelessWidget {
  const ChipsButton(
    this.width,
    this.height, {
    required this.image,
    required this.onPressed,
    super.key,
  });

  final String image;
  final double width, height;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: 0, minHeight: 0),
      onPressed: onPressed,
      icon: Image.asset(image, width: width, height: height),
    );
  }
}