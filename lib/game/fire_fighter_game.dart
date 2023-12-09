part of 'game.dart';

class FireFighterGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    final fireHose = FireHose()
      ..position = size / 2
      ..width = 50
      ..height = 100
      ..anchor = Anchor.center;

    add(fireHose);
  }
}
