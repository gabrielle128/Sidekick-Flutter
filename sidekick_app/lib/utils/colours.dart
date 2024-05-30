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
const shadowColor = Color(0xFFe8e8e8);
const redShadeColor = Color(0xFF9c677d);
const salmonColor = Color(0xFFef8076);
const greenShadeColor = Color(0xFF667b51);
const blueShadeColor = Color(0xFF5871b6);

// color palette
const color1 = Color(0xFFFFFFFF);
const color2 = Color(0xFFF0F0F2);
const color3 = Color(0xFFFDFD96);
const color4 = Color(0xFFF7C289);
const color5 = Color(0xFFD9B29C);
const color6 = Color(0xFFFFB6B3);
const color7 = Color(0xFFF7DCEA);
const color8 = Color(0xFFD5B9B1);
const color9 = Color(0xFFC784AF);
const color10 = Color(0xFFBCAFBD);
const color11 = Color(0xFF7393C2);
const color12 = Color(0xFFB6C7DD);
const color13 = Color(0xFFB4CBD9);
const color14 = Color(0xFF8D9365);
const color15 = Color(0xFFC1B985);
const color16 = Color(0xFFA7DBC8);
