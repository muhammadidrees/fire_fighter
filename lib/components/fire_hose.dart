part of 'components.dart';

const _movementSpeed = 20.0;
const _size = 32.0;

class FireHose extends PositionComponent with HasGameRef<FireFighterGame> {
  static final _paint = Paint()..color = Colors.white;
  final Vector2 speed = Vector2.zero();

  FireHose()
      : super(
          size: Vector2.all(_size),
          anchor: Anchor.center,
        );

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    position += speed * _size * dt;
    if (position.x > (gameRef.size.x / 2) - 50) {
      speed.x = -_movementSpeed;
    } else if (position.x < -(gameRef.size.x / 2) + 50) {
      speed.x = _movementSpeed;
    }
  }
}
