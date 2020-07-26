import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static final Color primary = Color(0xFFed0067), secondary = Color(0xFFe3327f), accent = Color(0xFFBA6B23), background1 = Color(0xFFFFFFFF);
  static final List<Color> gradient = [primary, secondary];

  static get gradientBackground {
    return BoxDecoration(boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)], gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: AppTheme.gradient));
  }

  static get shape {
    return RoundedRectangleBorder(borderRadius: borderRadius);
  }

  static get boxDecorationAppBar {
    return BoxDecoration(
      color: primary,
      borderRadius: BorderRadius.only(
        bottomLeft: radius,
        bottomRight: radius,
      ),
    );
  }

  static get boxDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.all(radius),
    );
  }

  static Radius get radius {
    return Radius.circular(16.00);
  }

  static BorderRadius get borderRadius {
    return BorderRadius.circular(16.00);
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
