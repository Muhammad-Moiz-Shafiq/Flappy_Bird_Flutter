import 'dart:math';
import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import 'pipe.dart';
import '../constants.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  // Update-> every second(dt) , new pipe to be generated
  double pipeSpawnTimer = 0;
  @override
  void update(double dt) {
    pipeSpawnTimer += dt;
    const double pipeSpawnInterval = 2.2;
    if (pipeSpawnTimer > pipeSpawnInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    //calculate pipe heights
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;
    //randomly calculating height of bottom pipe
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;
    //creating pipes
    final bottomPipe = Pipe(
      Vector2(pipeWidth, bottomPipeHeight),
      Vector2(gameRef.size.x, screenHeight - bottomPipeHeight - groundHeight),
      isTopPipe: false,
    );
    final topPipe = Pipe(
      Vector2(pipeWidth, topPipeHeight),
      Vector2(gameRef.size.x, 0),
      isTopPipe: true,
    );
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
