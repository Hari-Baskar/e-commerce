import "package:e_commerece/common_widgets/textWidget.dart";
import "package:flutter/material.dart";

message({
  required BuildContext context,
  required String text,
  required double fontSize,
  required FontWeight fontweight,
  required Color fontColor,
  required Color messageColor,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: messageColor,

      content: Center(
        child: textWidget(
          text: text,
          fontSize: fontSize,
          fontweight: fontweight,
          fontColor: fontColor,
        ),
      ),
    ),
  );
}
