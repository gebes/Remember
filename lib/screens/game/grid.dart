import 'dart:math';

import 'package:Remember/app/app.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameLogic extends StatefulWidget {
  final int gridLength;

  VoidCallback onWin, onLose;

  GameLogic(this.gridLength, {this.onWin, this.onLose});

  @override
  _GameLogicState createState() => _GameLogicState(this.gridLength);
}

class _GameLogicState extends State<GameLogic> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  final int gridLength;

  var fields = <Widget>[];
  var pattern;
  var haveBeenPressed = [];
  var wrongPress = -1;
  bool isShowingPattern = true;

  int current = -1;

  _GameLogicState(this.gridLength) {
    _generatePattern();
  }

  void _generatePattern() {
    pattern = [];
    for (int i = 0; i < gridLength * gridLength; i++) {
      int random;
      do {
        random = Utils.random(0, gridLength * gridLength);
      } while (pattern.contains(random));
      pattern.add(random);
    }
  }

  bool isWaiting = true;

  @override
  void initState() {
    controller = AnimationController(duration: Duration(seconds: gridLength * gridLength), vsync: this);
    animation = Tween<double>(begin: -1, end: (gridLength * gridLength).toDouble()).animate(controller)
      ..addListener(() {
        if (animation.value == gridLength * gridLength) {
          current = 0;
          setState(() {
            isShowingPattern = false;
          });
          return;
        }
        if (animation.value < 0) return;
        setState(() {
          int old = current;
          current = animation.value.toInt();
          if (old != current) audioCache.play("showingPattern.mp3");
        });
      });
    controller.forward();
    super.initState();
  }

  AudioCache audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    fields = [];
    for (int i = 0; i < gridLength * gridLength; i++)
      fields.add(Padding(
        padding: EdgeInsets.all(0),
        child: GestureDetector(
          child: Card(
            shadowColor: Colors.transparent,
            color: wrongPress == i ? AppTheme.accentRed4 : haveBeenPressed.contains(i) ? Colors.transparent : current >= 0 && pattern[current] == i && isShowingPattern ? Colors.green : Colors.black,
            //     child: wrongPress == i ? Container() : haveBeenPressed.contains(i)? Center(child: Text("${List.of(pattern).indexOf(i)+1}",style: TextStyle(fontSize: 36),)) : Container(),
          ),
          onTap: () {
            if (wrongPress != -1 || isShowingPattern || haveBeenPressed.contains(i)) return;
            setState(() {
              haveBeenPressed.add(i);
              if (pattern[current] != i) {
                wrongPress = i;
              }
              current++;
            });
            if (wrongPress == -1) audioCache.play("click.mp3");
            if (current == gridLength * gridLength || wrongPress != -1) {
              (wrongPress == -1) ? widget.onWin() : widget.onLose();
            }
          },
        ),
      ));
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisCount: gridLength,
        children: fields,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Utils {
  static final _random = new Random();

  static int random(int min, int max) => min + _random.nextInt(max - min);
}
