import 'dart:io';

import 'package:Remember/utils/navigator.dart';
import 'package:Remember/utils/rate.dart';
import 'package:Remember/utils/theme.dart';
import 'package:Remember/screens/game/grid.dart';
import 'package:Remember/utils/app_localizations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

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
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Stack(
        children: <Widget>[
          Container(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width+16,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: GameLogic(
                      widget.gridsize,
                      onLose: () async {
                        RememberApp.audioPlayer.play("wrong.mp3");
                        showDialog(false);
                      },
                      onWin: () async {
                        _confettiControllerLeft.play();
                        _confettiControllerRight.play();
                        RememberApp.audioPlayer.play("win.mp3");
                        showDialog(true);
                      },
                    ),
                  ),
                ),
              ),
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

  showDialog(bool hasWon) {
    AwesomeDialog dialog;
    if (hasWon) {
      dialog = AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          title: "",
          desc: AppLocalizations.of(context).translate('game.win'),
          btnOkOnPress: () {
            Navigator.pop(context);
            RateTheApp.showDialog(context);
          },
          btnOkText: AppLocalizations.of(context).translate('ok'),
          btnCancel: null);
    } else {
      dialog = AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        title: "",
        desc: AppLocalizations.of(context).translate('game.lose'),
        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        btnCancelText: AppLocalizations.of(context).translate('ok'),
        btnOk: null,
      );
    }
    dialog.show();
  }
}
