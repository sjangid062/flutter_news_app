import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.title,
      required this.color,
      required this.fontSize,
      required this.fontWeight,
      this.overflow,
      this.textAlign,
      this.maxLines});
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
            color: color, fontSize: fontSize, fontWeight: fontWeight));
  }
}
