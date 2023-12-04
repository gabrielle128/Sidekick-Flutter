import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

// LIST OF COLORS

const bgcolor = Color(0xFFDEDAD7);
const offWhite = Color(0xFFFAF9F6);
const bgcolorCV = Color(0xFFF3E9DD);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);
const yellow = Color(0xFFFFD75E);
const blue = Color(0xFF46679D);
const green = Color(0xFF04CE84);
const mustard = Color(0xFFFFBF37);
const red = Color(0xFFED4D45);
const navy = Color(0xFF476494);
const purple = Color(0xFFC5A8C7);
const skyblue = Color(0xFF87b6e2);
const moss = Color(0xFF91c16b);
const orange = Color(0xFFfe9037);
const pink = Color(0xFFffced9);
const grey = Color(0xFF808080);

const overdue = Color(0xFFef949d);
const today = Color(0xFFf0d89a);
const upcoming = Color(0xFF8cd3a9);
