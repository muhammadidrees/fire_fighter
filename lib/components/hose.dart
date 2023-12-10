part of 'components.dart';

const _movementSpeed = 16.0;
const _size = 200.0;

class Hose extends SpriteComponent
    with HasGameRef<FireFighterGame>, HasWorldReference {
  final Vector2 speed = Vector2.zero();
  late Sprite fireTruck;
  bool flipped = false;

  Hose()
      : super(
          size: Vector2.all(_size),
          anchor: Anchor.center,
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
    sprite = await Sprite.load('fire_truck.png');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // flip the sprite if the hose is moving to the left
    if (speed.x < 0 && !flipped) {
      flipHorizontally();
      flipped = true;
    }

    // flip the sprite if the hose is moving to the right
    if (speed.x > 0 && flipped) {
      flipHorizontally();
      flipped = false;
    }
  }

  @override
  void update(double dt) {
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
