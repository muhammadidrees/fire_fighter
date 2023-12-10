import 'package:fire_fighter/game/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _instructionOverlayKey = 'instructions';
const _gameOverOverlayKey = 'game_over';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/font/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(
    GameWidget(
      game: FireFighterGame(),
      initialActiveOverlays: const [_instructionOverlayKey],
      overlayBuilderMap: {
        _instructionOverlayKey: (BuildContext context, Game game) =>
            const IntiailOverLayText(),
        _gameOverOverlayKey: (BuildContext context, Game game) =>
            const GameOverOverlay(),
      },
    ),
  );
}

class IntiailOverLayText extends StatelessWidget {
  const IntiailOverLayText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome to Fire Fighter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(height: 36),

          // instructions
          Text(
            'Tap to use the hose to put out the fires',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'PressStart2P',
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Keep an eye on the heat meter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'PressStart2P',
            ),
          ),

          SizedBox(height: 8),

          Text(
            'If it gets too hot, you lose!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'PressStart2P',
            ),
          ),

          SizedBox(height: 24),

          Text(
            "Let's see how long you can keep the window cool :)",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'PressStart2P',
            ),
          ),

          SizedBox(height: 36),

          BlinkingText(),
        ],
      ),
    );
  }
}

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Game Over',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Refresh the screen to play again :)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

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
            'Tap to start',
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
