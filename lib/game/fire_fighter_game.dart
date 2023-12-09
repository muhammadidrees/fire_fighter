part of 'game.dart';

class FireFighterGame extends FlameGame with TapCallbacks {
  final Hose hose = Hose();
  bool isGameStarted = false;

  @override
  Future<void> onLoad() async {
    await world.add(
      hose..position = Vector2(0, (size.y / 2) - 50),
    );

    Timer.periodic(const Duration(seconds: 1), (_) {
      spawnFire();
    });

    return super.onLoad();
  }

  void spawnFire() {
    if (!isGameStarted) {
      return;
    }

    final random = Random();
    Vector2 position;
    bool overlaps;

    do {
      position = Vector2(
        random.nextDouble() * size.x,
        random.nextDouble() * size.y - 200,
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
    add(fire);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // start the game if the game is not started yet
    if (!isGameStarted) {
      hose.speed.x = 20;
      isGameStarted = true;

      return;
    }

    // if the game is started and the fire hose is not moving, do nothing
    if (hose.speed.x == 0) {
      return;
    }

    final isMovingRight = hose.speed.x > 0;

    hose.speed.x = 0;
    Timer(const Duration(seconds: 2), () {
      hose.speed.x = isMovingRight ? 20 : -20;
    });
  }
}
