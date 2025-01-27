import 'pipe.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';
import 'ground.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  // INIT bird
  //position and size of the bird
  Bird()
      : super(
            size: Vector2(birdHeight, birdWidth),
            position: Vector2(birdPosX, birdPosY));
  //physical
  double velocity = birdVelocity;
  double gravity = birdGravity;
  double jump = birdJump;
  //LOAD
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('bird.png');
    //collision box
    add(RectangleHitbox());
  }

  // JUMP/FLAP
  void flap() {
    velocity = jump;
  }

  //UPDATE
  @override
  void update(double dt) {
    super.update(dt);
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  //Collison Occured
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }
    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
