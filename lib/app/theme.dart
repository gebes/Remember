import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final Color accentRed1 = Color(0xFF6A0E14), accentRed2 = Color(0xFF950412), accentRed3 = Color(0xFFC80010), accentRed4 = Color(0xFFEF0022), accentRed5 = Color(0xFFF55B5F), accentRed6 = Color(0xFFFFA6A8), accentRed7 = Color(0xFFFFE7E8);
  static final Color accentGreen1 = Color(0xFF135239), accentGreen2 = Color(0xFF197741), accentGreen3 = Color(0xFF249D58), accentGreen4 = Color(0xFF38C171), accentGreen5 = Color(0xFF74D9A0), accentGreen6 = Color(0xFFA8EEC1), accentGreen7 = Color(0xFFE3FCEC);
  static final Color neutral1 = Color(0xFF112233), neutral2 = Color(0xFF5C6B7C), neutral3 = Color(0xFF8595A9), neutral4 = Color(0xFFB5C4CF), neutral5 = Color(0xFFCDD6DF), neutral6 = Color(0xFFE0E7EB), neutral7 = Color(0xFFFFFFFF);
  static final Color accentBlue1 = Color(0xFF143E56), accentBlue2 = Color(0xFF004A74), accentBlue3 = Color(0xFF0069A9), accentBlue4 = Color(0xFF0084CE), accentBlue5 = Color(0xFF4EA3DD), accentBlue6 = Color(0xFF9FD5F9);

  static final Color primary = Color(0xFFed0067), secondary = Color(0xFFe3327f), accent = Color(0xFFBA6B23), background1 = Color(0xFFFFFFFF);
  static final List<Color> gradient = [primary, secondary];

  static ThemeData current;

  static android(BuildContext context) {
    return ThemeData(
      primaryColor: AppTheme.primary,
      backgroundColor: Colors.white,
      splashColor: AppTheme.secondary,
      primarySwatch: MaterialColorBuilder.fromColor(AppTheme.secondary),
      buttonColor: AppTheme.secondary,
      textTheme: TextTheme(headline1: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: AppTheme.neutral7, fontSize: 32), button: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, fontSize: 24)),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      appBarTheme: AppBarTheme(color: primary),
      dialogTheme: DialogTheme(shape: shape),
      cardTheme: CardTheme(
        shape: shape,
      ),
      buttonTheme: ButtonThemeData(
        shape: shape,
        textTheme: ButtonTextTheme.accent,
        splashColor: AppTheme.primary,
        buttonColor: AppTheme.secondary,
        colorScheme: Theme.of(context).colorScheme.copyWith(secondary: neutral7), // Text color
      ),
    );
  }

  static get gradientBackground {
    return BoxDecoration(boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)], gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: AppTheme.gradient));
  }

  static get shape {
    return RoundedRectangleBorder(borderRadius: borderRadius);
  }

  static get boxDecorationAppBar {
    return BoxDecoration(
      color: primary,
      boxShadow: boxShadow,
      borderRadius: BorderRadius.only(
        bottomLeft: radius,
        bottomRight: radius,
      ),
    );
  }

  static get boxDecoration {
    return BoxDecoration(
      boxShadow: boxShadow,
      borderRadius: BorderRadius.all(radius),
    );
  }

  static Radius get radius {
    return Radius.circular(32.00);
  }

  static BorderRadius get borderRadius {
    return BorderRadius.circular(32.00);
  }

  static get boxShadow {
    return [
      BoxShadow(
        offset: Offset(0.00, 3.00),
        color: Color(0xff000000).withOpacity(0.16),
        blurRadius: 6,
      ),
    ];
  }

  static TextStyle get textStyle {
    return current.textTheme.bodyText1;
  }
}

class MaterialColorBuilder {
  static MaterialColor fromColor(Color color) {
    Map<int, Color> colors = {
      50: Color.fromRGBO(color.red, color.green, color.blue, .1),
      100: Color.fromRGBO(color.red, color.green, color.blue, .2),
      200: Color.fromRGBO(color.red, color.green, color.blue, .3),
      300: Color.fromRGBO(color.red, color.green, color.blue, .4),
      400: Color.fromRGBO(color.red, color.green, color.blue, .5),
      500: Color.fromRGBO(color.red, color.green, color.blue, .6),
      600: Color.fromRGBO(color.red, color.green, color.blue, .7),
      700: Color.fromRGBO(color.red, color.green, color.blue, .8),
      800: Color.fromRGBO(color.red, color.green, color.blue, .9),
      900: Color.fromRGBO(color.red, color.green, color.blue, 1),
    };
    return MaterialColor(color.value, colors);
  }
}
