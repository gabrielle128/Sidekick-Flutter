import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static List<Color> cardsColor = [
    Colors.blue.shade200,
    const Color.fromRGBO(255, 245, 157, 1),
    Colors.green.shade200,
    Colors.pink.shade100,
    Colors.purple.shade200,
    Colors.orange.shade200,
    Colors.red.shade100,
  ];

  static TextStyle mainTitle =
      GoogleFonts.gaegu(fontSize: 18.0, fontWeight: FontWeight.bold);

  static TextStyle mainDate =
      GoogleFonts.gaegu(fontSize: 12.0, fontWeight: FontWeight.normal);

  static TextStyle mainContent =
      GoogleFonts.gaegu(fontSize: 16.0, fontWeight: FontWeight.normal);
}
