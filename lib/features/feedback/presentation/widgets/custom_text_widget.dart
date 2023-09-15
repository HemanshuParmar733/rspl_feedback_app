import 'package:flutter/material.dart';

class FeedbackCardText extends StatelessWidget {
  const FeedbackCardText(
      {super.key,
      required this.text,
      this.maxLines,
      this.fontSize,
      this.fontWeight,
      this.overflow,
      this.textColor});

  final String text;
  final int? maxLines;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
          overflow: overflow, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
