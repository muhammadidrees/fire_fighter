part of 'components.dart';

class FireMeter extends PositionComponent {
  final int maxFires;
  int currentFires;

  FireMeter({required this.maxFires, required this.currentFires});

  @override
  FutureOr<void> onLoad() async {
    // add text component to left of fire meter
    final text = TextComponent(
      text: 'FIRE METER',
      size: Vector2.all(16),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          letterSpacing: 1.3,
          fontFamily: 'PressStart2P',
        ),
      ),
    )
      ..anchor = Anchor.topLeft
      ..position = Vector2(0, -24);

    await add(text);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.red;
    final rectSize = Vector2(20, 20); // size of each rectangle

    for (var i = 0; i < maxFires; i++) {
      final rectPos =
          Vector2(i * (rectSize.x + 10), 0); // position of each rectangle
      final rect = rectPos & rectSize;

      if (i < currentFires) {
        canvas.drawRect(rect, paint);
      } else {
        canvas.drawRect(rect, paint..color = Colors.blueGrey);
      }
    }
  }
}
