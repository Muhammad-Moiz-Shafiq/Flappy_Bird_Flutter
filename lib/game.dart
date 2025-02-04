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

  bool isGameOver = false;
  bool isGameStarted = false; // Indicates if the game has started

  // LOADING
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

    pauseEngine(); // Pause the game initially
  }

  // TAP
  @override
  void onTap() {
    if (isGameStarted) {
      bird.flap();
    }
  }

  // Game Over
  void gameOver() {
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
              //restartGame();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    ).then((_) {
      // Handle dialog dismissal (e.g., back button press)
      if (isGameOver) restartGame();
    });
  }

  void restartGame() {
    isGameOver = false;
    isGameStarted = false;
    bird.position = Vector2(birdPosX, birdPosY);
    bird.velocity = birdVelocity;
    score = 0;

    // Removing all pipes
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());

    pauseEngine();
    overlays.add('StartButton'); // Show the start button overlay again
  }

  // Start Game
  void startGame() {
    isGameStarted = true;
    overlays.remove('StartButton'); // Remove the start button overlay
    resumeEngine();
  }

  // Score
  int score = 0;
  void incrementScore() {
    score++;
  }
}
