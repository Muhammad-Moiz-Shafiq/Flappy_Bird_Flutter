import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlappyBirdGame gameInstance = FlappyBirdGame();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          GameWidget<FlappyBirdGame>(
            game: gameInstance,
            overlayBuilderMap: {
              'StartButton': (BuildContext context, FlappyBirdGame game) {
                return Center(
                  child: ElevatedButton(
                    onPressed: game.startGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              'WelcomeScreen': (BuildContext context, FlappyBirdGame game) {
                return WelcomeScreen(onTap: () {
                  game.overlays.remove('WelcomeScreen');
                  game.startGame();
                });
              },
            },
            initialActiveOverlays: const [
              'WelcomeScreen'
            ], // Show WelcomeScreen first
          ),
        ],
      ),
    );
  }
}
