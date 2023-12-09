part of 'game.dart';

class FireFighterGame extends FlameGame with TapCallbacks {
  final Hose hose = Hose();
  bool isGameStarted = false;

  @override
  Future<void> onLoad() async {
    await world.add(
      hose..position = Vector2(0, (size.y / 2) - 50),
    );
    return super.onLoad();
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
