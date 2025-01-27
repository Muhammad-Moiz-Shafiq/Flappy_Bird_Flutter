import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/pipeManager.dart';
import 'package:flappy_bird/components/scoreText.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flutter/material.dart';
import 'components/pipe.dart';
import 'components/background.dart';
import 'components/bird.dart';
import 'components/ground.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  /*
  Basic Components:
  Bg , Ground , pipes, Bird, score
   */

  late Bird bird;
  late Background bg;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;
  //LOADING
  @override
  FutureOr<void> onLoad() async {
    bg = Background(size);
    add(bg);
    ground = Ground();
    add(ground);
    pipeManager = PipeManager();
    add(pipeManager);
    scoreText = ScoreText();
    add(scoreText);
    bird = Bird();
    add(bird);
  }

  //TAP
  @override
  void onTap() {
    bird.flap();
  }

  //Game Over
  bool isGameOver = false;
  void gameOver() {
    //preventing multiple game over calls
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
        context: buildContext!,
        builder: (context) => AlertDialog(
              title: const Text('Game Over'),
              content: Text('Your Score: $score'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      restartGame();
                    },
                    child: Text('Restart'))
              ],
            ));
  }

  void restartGame() {
    isGameOver = false;
    bird.position = Vector2(birdPosX, birdPosY);
    bird.velocity = birdVelocity;
    score = 0;
    //removing all pipes
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }

  //SCORE
  int score = 0;
  void incrementScore() {
    score++;
  }
}
