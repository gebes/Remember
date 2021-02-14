import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remember/main.dart';
import 'package:remember/screens/game/game.dart';
import 'package:remember/screens/menu.dart';

class AppNavigator {
  static void navigateTo(String route, {dynamic args}) {
    RememberApp.navigatorKey.currentState.pushNamed(route, arguments: args);
  }

  static void clearAllAndNavigateTo(String route, {dynamic args}) {
    RememberApp.navigatorKey.currentState.pushNamedAndRemoveUntil(
        route, (Route<dynamic> route) => false,
        arguments: args);
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/menu':
        return MaterialPageRoute(builder: (_) => GameMenu());
      case '/game/game':
        return CupertinoPageRoute(builder: (_) => Game(args));
      //    return PageTransition(type: PageTransitionType.slideInLeft, child: Game(args), curve: Curves.easeOut);
      default:
        print("Error ${settings.name}");
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String route) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR\ntried to navigate to\n"$route"'),
        ),
      );
    });
  }
}
