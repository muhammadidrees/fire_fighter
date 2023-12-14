part of 'game.dart';

class FireFighterGame extends FlameGame
    with KeyboardEvents, HasCollisionDetection {
  final FireEngine fireEngine = FireEngine();
  bool isGameStarted = false;
  bool gameOver = false;
  int noOfFullGrownFires = 0;
  late TextComponent score;

  late FireMeter fireMeter;

  int gameScore = 0;

  @override
  Future<void> onLoad() async {
    await world.add(
      fireEngine..position = Vector2(0, (size.y / 2) - 50),
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

    do {
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
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    // if space bar not pressed, do nothing
    if (!keysPressed.contains(LogicalKeyboardKey.space)) {
      return KeyEventResult.ignored;
    }

    // start the game if the game is not started yet
    if (!isGameStarted) {
      fireEngine.speed.x = 20;
      isGameStarted = true;

      overlays.remove('instructions');

      // For looping an audio file
      FlameAudio.loop('background_music.mp3');

      return KeyEventResult.handled;
    }

    // if the game is started and the fire fireEngine is not moving, do nothing
    if (fireEngine.speed.x == 0) {
      return KeyEventResult.ignored;
    }

    final isMovingRight = fireEngine.speed.x > 0;

    fireEngine.speed.x = 0;
    Timer(const Duration(seconds: 1), () {
      fireEngine.speed.x = isMovingRight ? 20 : -20;
    });

    return KeyEventResult.handled;
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

    if (noOfFullGrownFires >= fireMeter.maxFires) {
      // some delay
      await Future.delayed(const Duration(milliseconds: 500));

      gameOver = true;

      overlays.add('game_over');

      Timer(const Duration(milliseconds: 100), pauseEngine);
    }
  }
}
