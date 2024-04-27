import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle inter_700_32_white = GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF));

  static TextStyle circularSid_450_12 = const TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFFFF));

  static TextStyle circularSid_300_122 = const TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 122,
      fontWeight: FontWeight.w300,
      color: Color(0xFFFFFFFF));
}
