import 'package:flutter/cupertino.dart';

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
      style: TextStyle(
          overflow: overflow,
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
