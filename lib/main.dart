import 'package:Remember/app/app.dart';
import 'package:Remember/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(
    App(
      App.init(
          title: Path("app.title"),
          home: GameMenu(),
          languages: {"de": "assets/de.json", "en": "assets/en.json"},
          language: "de",
          material: (context) => MaterialAppData(
                theme: AppTheme.android(context),
              ),
          cupertino: (context) => CupertinoAppData(
                theme: AppTheme.cupertino(context),
              ),
          isFullscreen: true),
    ),
  );
}
