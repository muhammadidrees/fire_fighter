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

  void shootWater() {
    final water = Water(
      Vector2(
        (gameRef.size.x / 2) + position.x,
        gameRef.size.y - 50,
      ),
    );
    gameRef.add(water);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    position += speed * _size * dt;

    if (gameRef.isGameStarted && speed.x == 0) {
      shootWater();
    }

    if (position.x > (gameRef.size.x / 2) - 50) {
      speed.x = -_movementSpeed;
    } else if (position.x < -(gameRef.size.x / 2) + 50) {
      speed.x = _movementSpeed;
    }
  }
}
