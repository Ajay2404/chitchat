import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.light;

  //Theme Colors
  bool isDark;
  Color txt;
  Color primary;
  Color primaryLight;
  Color secondary;
  Color accentTxt;
  Color bg1;
  Color bgColor;
  Color surface;
  Color error;
  Color transparentColor;

  //Extra Colors
  Color bgGray;
  Color gray;
  Color darkGray;
  Color lightGray;
  Color borderGray;
  Color green;
  Color white;
  Color whiteColor;
  Color blackText;
  Color blackColor;
  Color blackColor1;
  Color black12Color;
  Color textColor;
  Color contentColor;
  Color borderColor;
  Color greenColor;
  Color redColor;
  Color darkContentColor;
  Color ratingColor;
  Color homeCategoryColor;
  Color greyLight25;
  Color greyLight100;
  Color greyLight110;
  Color greyLight140;
  Color greyLight180;
  Color greyLight200;
  Color switchThumb;
  Color number;
  Color dark;
  Color text;

  /// Default constructor
  AppTheme({
    required this.isDark,
    required this.txt,
    required this.primary,
    required this.primaryLight,
    required this.secondary,
    required this.accentTxt,
    required this.bg1,
    required this.bgColor,
    required this.surface,
    required this.error,
    required this.transparentColor,
    //Extra
    required this.bgGray,
    required this.gray,
    required this.darkGray,
    required this.lightGray,
    required this.borderGray,
    required this.green,
    required this.white,
    required this.whiteColor,
    required this.blackText,
    required this.blackColor,
    required this.blackColor1,
    required this.black12Color,
    required this.textColor,
    required this.contentColor,
    required this.borderColor,
    required this.greenColor,
    required this.redColor,
    required this.darkContentColor,
    required this.ratingColor,
    required this.homeCategoryColor,
    required this.greyLight25,
    required this.greyLight100,
    required this.greyLight110,
    required this.greyLight140,
    required this.greyLight180,
    required this.greyLight200,
    required this.switchThumb,
    required this.number,
    required this.dark,
    required this.text
  });

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(
          isDark: false,
          txt: const Color(0xFF001928),
          primary: const Color(0xFF3164BD),
          primaryLight: const Color(0xFF4B84E7),
          secondary: const Color(0xFF6EBAE7),
          accentTxt: const Color(0xFF001928),
          bg1: Colors.white,
          bgColor: Colors.white,
          surface: Colors.white,
          error: const Color(0xFFd32f2f),
          transparentColor: Colors.transparent,
          //Extra
          bgGray: const Color(0xFFF0F8FD),
          gray: const Color(0xFF999999),
          darkGray: const Color(0xFF666666),
          lightGray: const Color(0xFFEDEFF4),
          borderGray: const Color(0xFFE6E8EA),
          green: const Color(0xFF5CB85C),
          white: Colors.white,
          whiteColor: Colors.white,
          blackText: const Color(0xFF222222),
          blackColor: Colors.black,
          blackColor1: Colors.black,
          black12Color: Colors.black12,
          contentColor: const Color(0xFF777777),
          borderColor: const Color(0xFFDDDDDD),
          greenColor: const Color(0xFF198754),
          redColor: Colors.red,
          darkContentColor: const Color(0xFFBABABA),
          ratingColor: const Color(0xFFFFBA49),
          homeCategoryColor: const Color(0xFFEAEDF2),
          textColor: Colors.white,
          greyLight25: const Color(0xFFEDEFF4),
          switchThumb: Colors.white10,
          number: const Color(0xff363941),
          dark: const Color(0xff010D21),
          greyLight100: Color(0x76b7b7b7),
          greyLight110: Color(0x8ec0bebe),
          greyLight140: Color(0x96ffffff),
          greyLight180: Color(0xFFD9D9D9),
          greyLight200: Color(0xff888888),
          text: Color(0xff333333),
        );

      case ThemeType.dark:
        return AppTheme(
          isDark: true,
          txt: Colors.black,
          primary: const Color(0xFF3467B8),
          primaryLight: const Color(0xFF202020),
          secondary: const Color(0xFF6EBAE7),
          accentTxt: const Color(0xFF001928),
          bg1: const Color(0xFF151A1E),
          bgColor: const Color(0xFF262626),
          surface: const Color(0xFF151A1E),
          error: const Color(0xFFd32f2f),
          transparentColor: Colors.transparent,
          //Extra
          bgGray: const Color(0xFF262F36),
          gray: const Color(0xFF999999),
          darkGray: const Color(0xFF999999),
          lightGray: const Color(0xFF202020),
          borderGray: const Color(0xFF353C41),
          green: const Color(0xFF5CB85C),
          white: Colors.white,
          whiteColor: Colors.black,
          blackText: const Color(0xFF262626),
          blackColor: Colors.white,
          blackColor1: Colors.black,
          black12Color: Colors.white12,
          contentColor: const Color(0xFF777777),
          borderColor: const Color(0xFFDDDDDD),
          greenColor: const Color(0xFF198754),
          redColor: Colors.red,
          darkContentColor: const Color(0xFFBABABA),
          ratingColor: const Color(0xFFFFBA49),
          textColor: const Color(0xFF636363),
          homeCategoryColor: const Color(0xFFEAEDF2),
          greyLight25: Colors.black,
          switchThumb: Colors.grey.shade500,
          number: const Color(0xff363941),
          dark: const Color(0xff010D21),
          greyLight100: Color(0x76bbb5b5),
          greyLight110: Color(0x8ec0bebe),
          greyLight140: Color(0x96ffffff),
          greyLight180: Color(0xFFD9D9D9),
          greyLight200: Color(0xFF888888),
          text: Color(0xff333333),
        );
    }
  }

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        secondary: secondary,
        background: bg1,
        surface: surface,
        onBackground: txt,
        onSurface: txt,
        onError: txt,
        onPrimary: accentTxt,
        onSecondary: accentTxt,
        error: error,
      ),
    );
    return t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: borderGray,
        selectionHandleColor: Colors.transparent,
        cursorColor: primary,
      ),
      buttonTheme: ButtonThemeData(buttonColor: primary),
      highlightColor: primary,
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return primary;
          }
          return null;
        }),
      ),
    );
  }
}
