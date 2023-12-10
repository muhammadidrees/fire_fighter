part of 'game.dart';

class FireFighterGame extends FlameGame
    with TapCallbacks, HasCollisionDetection {
  final Hose hose = Hose();
  bool isGameStarted = false;
  bool gameOver = false;
  int noOfFullGrownFires = 0;
  late TextComponent gameOverText;
  late TextComponent score;

  late FireMeter fireMeter;

  int gameScore = 0;

  @override
  Future<void> onLoad() async {
    await world.add(
      hose..position = Vector2(0, (size.y / 2) - 50),
    );

    score = TextComponent(
      text: 'SCORE: ${gameScore.toString().padLeft(5, '0')}',
      size: Vector2.all(16),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          letterSpacing: 1.3,
          fontFamily: 'PressStart2P',
        ),
      ),
    )
      ..anchor = Anchor.topRight
      ..priority = 10
      ..position = Vector2((size.x / 2) - 50, -(size.y / 2) + 50);

    await world.add(score);

    fireMeter = FireMeter(
      maxFires: 5,
      currentFires: noOfFullGrownFires,
    )
      ..anchor = Anchor.topLeft
      ..priority = 10
      ..position = Vector2(50, 50);

    add(fireMeter);

    Timer.periodic(const Duration(seconds: 3), (_) {
      spawnFire();
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      increaseScore();
    });

    return super.onLoad();
  }

  double generatePosition(double min, double max) {
    final random = Random();
    return min + random.nextDouble() * (max - min);
  }

  void increaseScore() {
    if (isGameStarted && !gameOver) {
      gameScore += 1;
      score.text = 'SCORE: ${gameScore.toString().padLeft(5, '0')}';
    }
  }

  void spawnFire() {
    if (!isGameStarted) {
      return;
    }

    Vector2 position;
    bool overlaps;

    // print("size.x: ${size.x}, size.y: ${size.y}");

    do {
      // spawn fire at a random position between -size.x to size.x
      // and -size.y to 200 (above the hose) also add a buffer of 100
      // so that the fire is not spawned at the edge of the screen
      position = Vector2(
        generatePosition(-size.x * 0.5 + 100, size.x * 0.5 - 100),
        generatePosition(-size.y * 0.5 + 300, size.y * 0.5 - 300),
      );

      overlaps = world.children.any((component) {
        if (component is Fire) {
          final fire = component;
          return fire
              .toRect()
              .inflate(50 - min(fire.size.x, fire.size.y))
              .overlaps(position.toPositionedRect(Vector2.all(50)));
        }
        return false;
      });
    } while (overlaps);

    final fire = Fire(position);
    world.add(fire);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // start the game if the game is not started yet
    if (!isGameStarted) {
      hose.speed.x = 20;
      isGameStarted = true;

      overlays.remove('instructions');

      return;
    }

    // if the game is started and the fire hose is not moving, do nothing
    if (hose.speed.x == 0) {
      return;
    }

    final isMovingRight = hose.speed.x > 0;

    hose.speed.x = 0;
    Timer(const Duration(seconds: 1), () {
      hose.speed.x = isMovingRight ? 20 : -20;
    });
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);

    noOfFullGrownFires = world.children.where((component) {
      if (component is Fire) {
        final fire = component;
        return fire.size.x >= 30 * 1.5;
      }
      return false;
    }).length;

    fireMeter.currentFires = noOfFullGrownFires;

    if (noOfFullGrownFires >= 5) {
      // some delay
      await Future.delayed(const Duration(milliseconds: 500));

      gameOver = true;

      gameOverText = TextComponent(
        text: 'Game Over',
        size: Vector2.all(32),
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: 'PressStart2P',
          ),
        ),
      )
        ..anchor = Anchor.center
        ..position = Vector2(0, 0);

      await world.add(gameOverText);

      Timer(const Duration(milliseconds: 100), pauseEngine);
    }
  }
}
