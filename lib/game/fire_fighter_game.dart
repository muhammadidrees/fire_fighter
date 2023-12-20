part of 'game.dart';

class FireFighterGame extends FlameGame
    with TapCallbacks, HasCollisionDetection {
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
          overlays.remove('game_over');
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

    await setupGame();

    return super.onLoad();
  }

  void increaseScore() {
    if (gameStateManager.isPlaying) {
      gameScore += 1;
      score.text = 'SCORE: ${gameScore.toString().padLeft(5, '0')}';
    }
  }

  Future<void> setupGame() async {
    if (gameStateManager.isPlaying) {
      return;
    }

    world.removeAll(world.children.query<Fire>());
    world.removeAll(world.children.query<FireEngine>());
    world.removeAll(world.children.query<Water>());
    world.removeAll(world.children.query<SpawnComponent>());
    world.removeAll(world.children.query<SpawnComponent>());
    world.removeAll(world.children.query<TextComponent>());
    world.removeAll(world.children.query<FireMeter>());

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
  }

  void startGame() {
    resumeEngine();

    fireEngine.speed.x = 20;

    final fireSpawner = SpawnComponent(
      factory: (_) => Fire(),
      period: 3.0,
      area: Rectangle.fromPoints(
        Vector2(xMin + kFireEngineSize * 1.5, yMin + kFireEngineSize * 2),
        Vector2(xMax - kFireEngineSize * 1.5, yMax - kFireEngineSize * 3),
      ),
    );

    world.add(fireSpawner);

    gameStateManager.state = GameState.playing;

    // For looping an audio file
    FlameAudio.loop('background_music.mp3');
  }

  @override
  Future<void> onTapDown(TapDownEvent event) async {
    super.onTapDown(event);

    if (gameStateManager.isGameOver) {
      await setupGame();
      startGame();
      return;
    }

    // start the game if the game is not started yet
    if (gameStateManager.isWelcome) {
      startGame();
      return;
    }

    // if the game is started and the fire fireEngine is not moving, do nothing
    if (fireEngine.speed.x == 0) {
      return;
    }

    final isMovingRight = fireEngine.speed.x > 0;

    fireEngine.speed.x = 0;
    Timer(const Duration(seconds: 1), () {
      fireEngine.speed.x = isMovingRight ? 20 : -20;
    });

    return;
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
