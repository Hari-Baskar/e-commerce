import 'package:e_commerece/common_widgets/textWidget.dart';
import 'package:flutter/material.dart';

buttonWidget({
  required String text,
  required double fontSize,
  required FontWeight fontweight,
  required Color fontColor,
  required double buttonWidth,
  required Color buttonColor,
  double? verticalPadding,
  Color? borderColor,
}) {
  return Container(
    width: buttonWidth,
    decoration: BoxDecoration(
      color: buttonColor,
      border: Border.all(color: borderColor ?? buttonColor, width: 0.2),
      borderRadius: BorderRadius.circular(15),
    ),
    padding: EdgeInsetsGeometry.symmetric(vertical: verticalPadding ?? 10),
    child: Center(
      child: textWidget(
        text: text,
        fontSize: fontSize,
        fontweight: fontweight,
        fontColor: fontColor,
      ),
    ),
  );
}
