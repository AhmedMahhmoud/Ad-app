import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// here we put all of our constants

const white = Colors.white;
const black = Colors.black;
const green = Colors.green;
const red = Colors.red;
const maincolor1 = Color.fromRGBO(32, 93, 177, 1);
const maincolor2 = Color.fromRGBO(206, 206, 206, 1);
const maincolor3 = Color.fromRGBO(240, 240, 240, 1);

dw(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

dh(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

gTextW(
  String text,
  Color color,
  TextAlign textAlign,
  int maxLines,
  double fontSize,
  FontWeight fontWeight,
) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontSize: fontSize.w,
        fontWeight: fontWeight,
        fontFamily: "driod_arabic"),
    textDirection: TextDirection.rtl,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
  );
}

logoText(
  Color color,
  double fontSize,
) {
  return Text(
    "SEVEN",
    style: TextStyle(
        color: color,
        fontSize: fontSize.w,
        fontWeight: FontWeight.bold,
        fontFamily: "logo_font"),
    textDirection: TextDirection.rtl,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
  );
}
