part of 'widgets.dart';

class BlinkingText extends StatefulWidget {
  const BlinkingText({super.key});

  @override
  State<BlinkingText> createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _animationController.value,
          child: const Text(
            'Press space to start',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'PressStart2P',
            ),
          ),
        );
      },
    );
  }
}
