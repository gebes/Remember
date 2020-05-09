library app;

import 'package:Remember/app/lang.dart';
import 'package:Remember/app/navigator.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome, SystemUiOverlay, SystemUiOverlayStyle, rootBundle;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:audioplayers/audio_cache.dart';

export 'lang.dart';
export 'widgets.dart';
export 'navigator.dart';
export 'theme.dart';

class App extends StatefulWidget {
  static AudioCache audioPlayer = AudioCache();

  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static LanguageManager languageManager;

  static Path title;

  static Widget home;

  static PlatformBuilder<MaterialAppData> material;
  static PlatformBuilder<CupertinoAppData> cupertino;

  static bool isFullscreen = false;

  static bool _finishedLoading = false;

  static Future init({@required Path title, @required Widget home, @required bool isFullscreen, @required Map<String, String> languages, @required String language, @required PlatformBuilder<MaterialAppData> material, @required PlatformBuilder<CupertinoAppData> cupertino}) async {
    _finishedLoading = false;
    WidgetsFlutterBinding.ensureInitialized();
    App.title = title;
    App.home = home;
    App.material = material;
    App.cupertino = cupertino;
    App.isFullscreen = isFullscreen;

    print("Now loading languages...");
    languageManager = LanguageManager();
    for (MapEntry<String, String> entry in languages.entries) {
      await languageManager.addLanguage(assetPath: entry.value, code: entry.key);
    }

    languageManager.setLanguage((await Devicelocale.currentLocale).substring(0, 2));
    _finishedLoading = true;
    print("Finished loading");
  }

  Future future;

  App(this.future);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (App.isFullscreen) {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
    return FutureBuilder(
      future: widget.future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.waiting:
            return Container();
          default:
            return PlatformApp(
              onGenerateRoute: RouteGenerator.generateRoute,
              navigatorKey: App.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: App.title.get,
              home: App.home,
              android: App.material,
              ios: App.cupertino,
            );
        }
      },
    );
  }
}
