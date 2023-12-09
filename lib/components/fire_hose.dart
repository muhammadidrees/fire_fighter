part of 'components.dart';

class FireHose extends PositionComponent {
  static final _paint = Paint()..color = Colors.white;

  FireHose(Vector2 canvasSize) {
    position = Vector2(canvasSize.x / 2, canvasSize.y - 80);
    size = Vector2(50, 50);
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }
}
