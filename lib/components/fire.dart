part of 'components.dart';

class Fire extends PositionComponent
    with HasGameRef<FireFighterGame>, CollisionCallbacks {
  static final _paint = Paint()..color = Colors.red;
  final Vector2 growthRate = Vector2.all(5);

  int hitPoints = 10;

  Fire(Vector2 position)
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Water) {
      hitPoints--;
      if (hitPoints <= 0) {
        removeFromParent();
        gameRef.noOfFullGrownFires++;
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (size.x < 50) {
      Timer(const Duration(seconds: 2), () {
        size += growthRate * dt;
      });
    }
  }
}
