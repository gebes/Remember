import 'package:Remember/utils/navigator.dart';
import 'package:Remember/utils/theme.dart';
import 'package:Remember/utils/app_localizations.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameMenu extends StatefulWidget {
  @override
  _GameMenuState createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {
  AudioCache player = new AudioCache();

  button(int size) {
    return MaterialButton(
      color: AppTheme.primary,
      onPressed: () {
        AppNavigator.navigateTo("/game/game", args: size);
        player.play("select.mp3");
      },
      child: Text(
        AppLocalizations.of(context).translate("menu.${size}x$size"),
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
      padding: EdgeInsets.all(24),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: AppTheme.gradient,
        )),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //      Text(Path("app.title").get, style: TextStyle(fontSize: 48, color: AppTheme.neutral7),),
                    // Image.asset("assets/logo.png"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: FlareActor("assets/Logo.flr", animation: "hover",),
                    ),
                    Text(
                      AppLocalizations.of(context).translate("app.subtitle"),
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        button(2),
                        button(3),
                        button(4),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
