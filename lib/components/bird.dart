import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';

class Bird extends SpriteComponent {
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
}
