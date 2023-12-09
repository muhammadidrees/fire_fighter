part of 'game.dart';

class FireFighterGame extends FlameGame with TapCallbacks {
  final FireHose fireHose = FireHose();

  bool isMovingRight = true;

  @override
  Future<void> onLoad() async {
    await world.add(
      fireHose..position = Vector2(0, (size.y / 2) - 50),
    );
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (fireHose.speed.x == 0) {
      fireHose.speed.x = isMovingRight ? 20 : -20;
    } else {
      isMovingRight = fireHose.speed.x > 0;
      fireHose.speed.x = 0;
    }
  }
}
