part of 'components.dart';

const _fireSize = 30.0;

class Fire extends SpriteAnimationComponent
    with HasGameRef<FireFighterGame>, CollisionCallbacks {
  final Vector2 growthRate = Vector2.all(5);

  int hitPoints = 10;

  Fire(Vector2 position)
      : super(
          size: Vector2(_fireSize, _fireSize + 10),
          position: position,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    final sprites = [
      0,
      1,
      2,
      3,
      4,
      5,
    ].map(
      (i) => Sprite.load(
        'sprite_fire$i.png',
      ),
    );

    animation = SpriteAnimation.spriteList(
      await Future.wait(sprites),
      stepTime: 0.08,
    );

    add(RectangleHitbox());
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
    super.update(dt);
    if (size.x < _fireSize * 1.5) {
      Timer(const Duration(seconds: 2), () {
        size += growthRate * dt;
      });
    }
  }
}
