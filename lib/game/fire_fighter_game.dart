part of 'game.dart';

class FireFighterGame extends FlameGame
    with KeyboardEvents, HasCollisionDetection {
  FireFighterGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: kGameWidth,
            height: kGameHeight,
          ),
        );

  final gameStateManager = GameStateManager();
  late FireEngine fireEngine;

  int noOfFullGrownFires = 0;
  late TextComponent score;

  late FireMeter fireMeter;

  int gameScore = 0;

  double get width => size.x;

  double get height => size.y;

  double get xMax => width / 2;

  double get xMin => -width / 2;

  double get yMax => height / 2;

  double get yMin => -height / 2;

  @override
  Future<void> onLoad() async {
    gameStateManager.onStateChange.listen((state) {
      switch (state) {
        case GameState.playing:
          overlays.remove('instructions');
          break;
        case GameState.gameOver:
          overlays.add('game_over');
          break;

        case GameState.welcome:
          break;
      }
    });

    final playArea = PlayArea();

    await world.add(playArea);

    fireEngine = FireEngine(
      position: Vector2(0, yMax),
      size: kFireEngineSize,
    );

    debugMode = true;

    await world.add(fireEngine);

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
      position: Vector2(-(size.x / 2) + 50, -(size.y / 2) + 50),
    )
      ..anchor = Anchor.topLeft
      ..priority = 10;

    await world.add(fireMeter);

    Timer.periodic(const Duration(seconds: 1), (timer) {
      increaseScore();
    });

    return super.onLoad();
  }

  void increaseScore() {
    if (gameStateManager.isPlaying) {
      gameScore += 1;
      score.text = 'SCORE: ${gameScore.toString().padLeft(5, '0')}';
    }
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
    if (gameStateManager.isWelcome) {
      fireEngine.speed.x = 20;

      final fireSpawner = SpawnComponent(
        factory: (_) => Fire(),
        period: 3,
        area: Rectangle.fromPoints(
          Vector2(xMin + 260, yMin + 300),
          Vector2(xMax + 260, yMax - 300),
        ),
      );

      world.add(fireSpawner);

      gameStateManager.state = GameState.playing;

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

      gameStateManager.state = GameState.gameOver;

      Timer(const Duration(milliseconds: 100), pauseEngine);
    }
  }
}
