part of 'components.dart';

class Water extends PositionComponent with HasGameRef<FireFighterGame> {
  static final _paint = Paint()..color = Colors.blue;
  final Vector2 speed = Vector2(0, -160);

  Water(Vector2 position)
      : super(
          size: Vector2.all(10),
          position: position,
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    position += speed * dt;

    // if the water goes off screen, remove it
    if (position.y < gameRef.size.y * -1) {
      removeFromParent();
    }
  }
}
