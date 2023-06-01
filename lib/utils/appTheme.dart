import 'package:flutter/material.dart';
import '../utils/prefrences.dart';


Color transparent = Color(0x00000000);

//------------------------------DARK THEME GRADIANT ----------------------------//

Color get LightTheme_BackgroundColor => Colors.white;
Color get LightTheme_MainHighlighter => Colors.pink;
Color get LightTheme_SecondaryHighlighter => Colors.cyan;
Color get LightTheme_NormalColor => Colors.black;

// Color get DarkTheme_BackgroundColor => Color(0xff15202B);
Color get DarkTheme_BackgroundColor => Color(0xff081622);
Color get DarkTheme_MainHighlighter => Colors.white;
Color get DarkTheme_SecondaryHighlighter => Color(0xffFFC222);
Color get DarkTheme_NormalColor => Color(0xffFFC222);


Color get BackgroundColor => isDarkTheme()? DarkTheme_BackgroundColor: LightTheme_BackgroundColor;
Color get MainHighlighter => isDarkTheme()? DarkTheme_MainHighlighter: LightTheme_MainHighlighter;
Color get SecondaryHighlighter => isDarkTheme()? DarkTheme_SecondaryHighlighter: LightTheme_SecondaryHighlighter;
Color get NormalColor => isDarkTheme()? DarkTheme_NormalColor: LightTheme_NormalColor;
