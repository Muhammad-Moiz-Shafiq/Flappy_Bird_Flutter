import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameWidget(
        game: FlappyBirdGame(),
        overlayBuilderMap: {
          'StartButton': (BuildContext context, FlappyBirdGame game) {
            return Center(
              child: Container(
                color: Colors.transparent, // Ensure background is clear
                child: ElevatedButton(
                  onPressed: game.startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Green button
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
              ),
            );
          },
        },
      ),
    );
  }
}
