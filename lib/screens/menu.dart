import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:Remember/app/app.dart';

class GameMenu extends StatefulWidget {
  @override
  _GameMenuState createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {
  AudioCache player = new AudioCache();

  button(int size) {
    return BeautifulButton(
      onPressed: () {
        AppNavigator.navigateTo("/game/game", args: size);
        player.play("select.mp3");
      },
      child: Text(Path("menu.${size}x$size").get),
      padding: EdgeInsets.all(24),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return PlatformScaffold(
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
                    Image.asset("assets/logo.png"),
                    Text(
                      Path("app.subtitle").get,
                      style: TextStyle(fontSize: 28, color: AppTheme.neutral7),
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
