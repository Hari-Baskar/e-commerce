import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

textfieldWidget({
  required String hintText,
  required TextEditingController controller,
  TextInputType? type,
  required Color hintColor,
  required double hintSize,
  Icon? prefixIcon,
  dynamic onTap,
  int? minlines,
  dynamic suffix,
  dynamic prefix,
  bool? obscure,
  bool? readonly,
  double? maxlength,
  dynamic OnChanged,
  dynamic focusnode,
  dynamic validate,
}) {
  return TextFormField(
    onTap: onTap,
    validator: validate,
    focusNode: focusnode,
    obscureText: obscure ?? false,
    minLines: minlines,
    onChanged: OnChanged,
    readOnly: readonly ?? false,
    maxLines: obscure != null ? 1 : null,
    keyboardType: type,
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,

      hintText: hintText,

      suffixIcon: suffix,
      prefix: prefix,

      hintStyle: GoogleFonts.poppins(
        fontSize: hintSize,
        fontWeight: FontWeight.w500,
        color: hintColor,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}
