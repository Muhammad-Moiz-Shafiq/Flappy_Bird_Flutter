import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';

import '../constants.dart';

class Pipe extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  bool isTopPipe;
  bool scored = false;
  Pipe(Vector2 size, Vector2 position, {required this.isTopPipe})
      : super(size: size, position: position);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'top_pipe.png' : 'bottom_pipe.png');
    //collision box
    add(RectangleHitbox());
  }

  //UPDATE
  @override
  void update(double dt) {
    super.update(dt);
    position.x -= groundSpeed * dt;
    if (!scored && gameRef.bird.position.x > position.x + size.x) {
      scored = true;
      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }
    //infinite scroll effect
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
