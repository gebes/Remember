import 'dart:io';

import 'package:Remember/app/app.dart';
import 'package:Remember/screens/game/grid.dart';
import 'package:Remember/utils/rate.dart';
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
                        App.audioPlayer.play("wrong.mp3");
                        showDialog(Path('game.lose').text, false);
                      },
                      onWin: () async {
                        _confettiControllerLeft.play();
                        _confettiControllerRight.play();
                        App.audioPlayer.play("win.mp3");
                        showDialog(Path('game.win').text, true);
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

  showDialog(Text content, bool hasWon) {
    showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
              content: content,
              actions: <Widget>[
                PlatformDialogAction(
                  child: Path('ok').text,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    if (hasWon) {
                      RateTheApp.showDialog(context);
                    }
                  },
                )
              ],
            ));
  }
}
