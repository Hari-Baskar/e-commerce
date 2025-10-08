import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

textWidget({
  required String text,
  required double fontSize,
  required FontWeight fontweight,
  required Color fontColor,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    overflow: overflow,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: fontColor,
    ),
  );
}
