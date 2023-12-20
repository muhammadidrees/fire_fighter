part of 'components.dart';

const _movementSpeed = 16.0;

class FireEngine extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<FireFighterGame>, HasWorldReference {
  Vector2 speed = Vector2.zero();
  late Sprite fireTruck;
  bool flipped = false;

  FireEngine({
    required super.position,
    required double size,
  }) : super(
          size: Vector2(size * 1.4, size),
          anchor: Anchor.bottomCenter,
          priority: 10,
        );

  void shootWater() {
    final water = Water(
      Vector2(
        position.x,
        position.y - (height / 2),
      ),
    );
    world.add(water);
  }

  @override
  Future<void> onLoad() async {
    final hitBox = RectangleHitbox(
      size: Vector2(width, height / 2),
    );

    add(hitBox);

    final sprites = [
      0,
      1,
    ].map(
      (i) => Sprite.load(
        'fire_truck/sprite_truck$i.png',
      ),
    );
    animation = SpriteAnimation.spriteList(
      await Future.wait(sprites),
      stepTime: 0.1,
    );
  }

  void flip() {
    flipHorizontally();
    speed.x = -speed.x;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      final isCollidingWithPlayAreaHorizontalEdges =
          intersectionPoints.first.x >= game.xMax ||
              intersectionPoints.first.x <= game.xMin;

      if (isCollidingWithPlayAreaHorizontalEdges) {
        flip();
      }
    } else {
      debugPrint('collision with $other');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += speed * _movementSpeed * dt;

    if (gameRef.gameStateManager.isPlaying && speed.x == 0) {
      shootWater();
    }
  }
}
