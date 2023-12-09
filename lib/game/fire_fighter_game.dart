part of 'game.dart';

class FireFighterGame extends FlameGame with TapCallbacks {
  final FireHose fireHose = FireHose();
  bool isGameStarted = false;

  @override
  Future<void> onLoad() async {
    await world.add(
      fireHose..position = Vector2(0, (size.y / 2) - 50),
    );
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    // start the game if the game is not started yet
    if (!isGameStarted) {
      fireHose.speed.x = 20;
      isGameStarted = true;

      return;
    }

    // if the game is started and the fire hose is not moving, do nothing
    if (fireHose.speed.x == 0) {
      return;
    }

    final isMovingRight = fireHose.speed.x > 0;

    fireHose.speed.x = 0;
    Timer(const Duration(seconds: 2), () {
      fireHose.speed.x = isMovingRight ? 20 : -20;
    });
  }
}
