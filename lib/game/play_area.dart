part of 'game.dart';

class PlayArea extends RectangleComponent
    with HasGameReference<FireFighterGame> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xFF000000),
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(
      game.width,
      game.height,
    );
  }
}
