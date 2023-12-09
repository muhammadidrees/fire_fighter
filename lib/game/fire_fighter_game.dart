part of 'game.dart';

class FireFighterGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    final fireHose = FireHose(size);

    add(fireHose);
  }
}
