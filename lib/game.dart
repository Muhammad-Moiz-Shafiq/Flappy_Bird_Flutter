import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'components/background.dart';
import 'components/bird.dart';
import 'components/ground.dart';

class FlappyBirdGame extends FlameGame with TapDetector {
  /*
  Basic Components:
  Bg , Ground , pipes, Bird, score
   */

  late Bird bird;
  late Background bg;
  late Ground ground;
  //LOADING
  @override
  FutureOr<void> onLoad() async {
    bg = Background(size);
    add(bg);
    ground = Ground();
    add(ground);
    bird = Bird();
    add(bird);
  }

  //TAP
  @override
  void onTap() {
    bird.flap();
  }
}
