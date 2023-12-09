part of 'components.dart';

class Fire extends PositionComponent with HasGameRef<FireFighterGame> {
  static final _paint = Paint()..color = Colors.red;
  final Vector2 growthRate = Vector2.all(5);

  Fire(Vector2 position)
      : super(
          size: Vector2.all(10),
          position: position,
          anchor: Anchor.center,
        );

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    if (size.x < 50) {
      size += growthRate * dt;
    }
  }
}
