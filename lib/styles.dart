import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const BLACK = Color(0xff333333);
const PURPLE = Color(0xff574B90);
const PURPLE_DARK = Color(0xff39315F);
const WHITE = Color(0xffffffff);
const TRANSPARENT_WHITE = Color(0x80ffffff);
const RED = Color(0xffD64541);
const GREEN = Color(0xff3FC380);

final heading = GoogleFonts.prompt(fontSize: 22, color: WHITE);

final body = GoogleFonts.prompt(fontSize: 18, color: WHITE);

final bodyTransparent =
    GoogleFonts.prompt(fontSize: 18, color: TRANSPARENT_WHITE);

final subBody = GoogleFonts.prompt(fontSize: 16, color: TRANSPARENT_WHITE);

final cardBody = GoogleFonts.prompt(fontSize: 16, color: WHITE);

final cardSubtext = GoogleFonts.prompt(fontSize: 16, color: TRANSPARENT_WHITE);

const PADDING = 16.0;

final buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
            return PURPLE_DARK; // Use the component's default.
        }),
);