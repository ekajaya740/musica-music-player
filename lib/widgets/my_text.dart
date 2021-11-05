import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlign;
  final int maxLines;

  const MyText(
    this.text, {
    Key? key,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 16,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      maxLines: maxLines,
    );
  }
}
