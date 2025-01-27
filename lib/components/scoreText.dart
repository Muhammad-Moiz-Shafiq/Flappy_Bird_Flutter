import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame> {
  ScoreText()
      : super(
            text: '0',
            textRenderer: TextPaint(
                style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 48.0,
            )));

  //LOAD
  @override
  FutureOr<void> onLoad() {
    position =
        Vector2((gameRef.size.x - size.x) / 2, gameRef.size.y - 50 - size.y);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final newText = gameRef.score.toString();
    if (text != newText) {
      text = newText;
    }
  }
}
