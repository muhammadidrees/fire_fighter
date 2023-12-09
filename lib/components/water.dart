part of 'components.dart';

class Water extends PositionComponent with HasGameRef<FireFighterGame> {
  static final _paint = Paint()..color = Colors.blue;
  final Vector2 speed = Vector2(0, -50);

  Water(Vector2 position)
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
    position += speed * dt;
  }
}
