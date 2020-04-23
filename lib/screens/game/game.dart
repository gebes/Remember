import 'dart:io';

import 'package:Remember/app/app.dart';
import 'package:Remember/screens/game/grid.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Game extends StatefulWidget {
  final int gridsize;

  Game(this.gridsize);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  ConfettiController _confettiControllerRight, _confettiControllerLeft;

  @override
  void initState() {
    _confettiControllerLeft = ConfettiController(duration: const Duration(seconds: 4));
    _confettiControllerRight = ConfettiController(duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    _confettiControllerLeft.dispose();
    _confettiControllerRight.dispose();
    super.dispose();
  }

  static AudioCache audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
    return PlatformScaffold(
      backgroundColor: AppTheme.primary,
      body: Stack(
        children: <Widget>[
          Container(
            child: Center(
              child: Card(
                  child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: GameLogic(
                      widget.gridsize,
                      onLose: () async {
                        audioCache.play("wrong.mp3");
                        AwesomeDialog(
                                context: context,
                                animType: AnimType.BOTTOMSLIDE,
                                dialogType: DialogType.ERROR,
                                body: Center(
                                  child: Text(
                                    Path('game.lose').get,
                                  ),
                                ),
                                btnOk: PlatformButton(
                                  color: AppTheme.accentRed4,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 8, bottom: 8),
                                    child: Text(
                                      Path("ok").get,
                                      style: TextStyle(color: AppTheme.neutral7),
                                    ),
                                  ),
                                ),
                                headerAnimationLoop: false,
                                dismissOnTouchOutside: false)
                            .show();
                      },
                      onWin: () async {
                        _confettiControllerLeft.play();
                        _confettiControllerRight.play();
                        audioCache.play("win.mp3");
                        AwesomeDialog(
                                context: context,
                                animType: AnimType.BOTTOMSLIDE,
                                dialogType: DialogType.SUCCES,
                                headerAnimationLoop: false,
                                body: Center(
                                  child: Text(
                                    Path('game.win').get,
                                  ),
                                ),
                                btnOk: PlatformButton(
                                  color: AppTheme.accentGreen4,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 8, bottom: 8),
                                    child: Text(
                                      Path("ok").get,
                                      style: TextStyle(color: AppTheme.neutral7),
                                    ),
                                  ),
                                ),
                                dismissOnTouchOutside: false)
                            .show();
                      },
                    ),
                  ),
                ],
              )),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ConfettiWidget(
              confettiController: _confettiControllerLeft,
              blastDirection: -3.14159 / 2.6,
              emissionFrequency: 0.02,
              numberOfParticles: 22,
              maxBlastForce: 120,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ConfettiWidget(
              confettiController: _confettiControllerRight,
              blastDirection: -3.14159 / 1.6,
              emissionFrequency: 0.02,
              numberOfParticles: 22,
              maxBlastForce: 120,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
