import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remember/screens/menu.dart';
import 'package:remember/utils/app_localizations.dart';
import 'package:remember/utils/navigator.dart';
import 'package:remember/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(RememberApp());
}

class RememberApp extends StatelessWidget {
  static AudioCache audioPlayer = AudioCache();
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Remember",
      home: GameMenu(),
      navigatorKey: navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primaryColor: AppTheme.primary,
        backgroundColor: Colors.white,
        splashColor: AppTheme.secondary,
        primarySwatch: MaterialColorBuilder.fromColor(AppTheme.secondary),
        buttonColor: AppTheme.secondary,
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
        appBarTheme: AppBarTheme(color: AppTheme.primary),
        cardTheme: CardTheme(
          shape: AppTheme.shape,
        ),
        buttonTheme: ButtonThemeData(
          shape: AppTheme.shape,
          textTheme: ButtonTextTheme.accent,
          splashColor: AppTheme.primary,
          buttonColor: AppTheme.secondary,
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(secondary: Colors.white), // Text color
        ),
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
    );
  }
}
