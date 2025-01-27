import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import '../constants.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Ground() : super();

  @override
  Future<void> onLoad() async {
    size = Vector2(gameRef.size.x * 2, groundHeight);
    position = Vector2(0, size.y - groundHeight);
    sprite = await Sprite.load('ground.png');
  }

  //UPDATE
  @override
  void update(double dt) {
    super.update(dt);
    position.x -= groundSpeed * dt;
    //infinite scroll effect
    if (position.x <= -gameRef.size.x) {
      position.x = 0;
    }
  }
}
