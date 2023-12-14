part of 'components.dart';

const _movementSpeed = 16.0;
const _size = 60.0;

class FireEngine extends SpriteAnimationComponent
    with HasGameRef<FireFighterGame>, HasWorldReference {
  final Vector2 speed = Vector2.zero();
  late Sprite fireTruck;
  bool flipped = false;

  FireEngine()
      : super(
          size: Vector2(_size + 20, _size),
          anchor: Anchor.center,
          priority: 2,
        );

  void shootWater() {
    final water = Water(
      Vector2(
        position.x,
        position.y,
      ),
    );
    world.add(water);
  }

  @override
  Future<void> onLoad() async {
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

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // flip the sprite if the fireEngine is moving to the left
    if (speed.x < 0 && !flipped) {
      flipHorizontally();
      flipped = true;
    }

    // flip the sprite if the fireEngine is moving to the right
    if (speed.x > 0 && flipped) {
      flipHorizontally();
      flipped = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += speed * 16 * dt;

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
