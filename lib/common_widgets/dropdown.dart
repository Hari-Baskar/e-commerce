import 'package:e_commerece/common_widgets/common_colors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

dropDownWidget({
  required String label,
  required double labelSize,
  required List items,
  required dynamic onchange,
  required String value,
}) {
  return DropdownButtonFormField(
    decoration: InputDecoration(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: labelSize,
          fontWeight: FontWeight.w500,
          color: grey,
        ),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    ),
    items: items
        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList(),
    onChanged: onchange,
    value: value,
  );
}

dropDownWidget2({
  required List items,
  required dynamic onchange,
  required String value,
  required double labelSize,
  required String label,
  required double fontSize,
  required double iconSize,
}) {
  return DropdownButtonFormField(
    decoration: InputDecoration(
      labelText: label, // 👈 your label
      labelStyle: GoogleFonts.poppins(fontSize: labelSize),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: black, width: 1),
      ),
    ),
    isDense: true, // 👈 removes extra vertical padding
    iconSize: iconSize,
    isExpanded: true, // 👈 smaller arrow
    style: GoogleFonts.poppins(fontSize: fontSize, color: black),
    items: items
        .map(
          (e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e, style: GoogleFonts.poppins()),
          ),
        )
        .toList(),
    onChanged: onchange,
    value: value,
  );
}
