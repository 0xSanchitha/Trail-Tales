import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primary = Color.fromARGB(255, 1, 101, 91);
const bg = Color.fromARGB(255, 2, 131, 118);
const btngray = Color.fromARGB(255, 26, 29, 41);
const white = Colors.white;
const black = Colors.black;

//font sizes

final h1 = GoogleFonts.koulen(
  fontSize: 40.0,
  color: white,
  fontWeight: FontWeight.bold,
);

final h2 = GoogleFonts.koulen(
  fontSize: 50.0,
  color: white,
  fontWeight: FontWeight.bold,
);

final body = GoogleFonts.koulen(
  fontSize: 18.0,
  color: white,
  fontWeight: FontWeight.w400,
);

final body2 = GoogleFonts.afacad(
  fontSize: 16.0,
  color: btngray,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5
);