part of 'game.dart';

class FireFighterGame extends FlameGame with TapCallbacks {
  final FireHose fireHose = FireHose();

  @override
  Future<void> onLoad() async {
    await world.add(
      fireHose..position = Vector2(0, (size.y / 2) - 50),
    );
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    fireHose.speed.x = 100;
  }
}
