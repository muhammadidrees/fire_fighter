part of 'view.dart';

const _instructionOverlayKey = 'instructions';
const _gameOverOverlayKey = 'game_over';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const GamePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FireFighterGame(),
      initialActiveOverlays: const [_instructionOverlayKey],
      overlayBuilderMap: {
        _instructionOverlayKey: (BuildContext context, Game game) =>
            const IntiailOverLayText(),
        _gameOverOverlayKey: (BuildContext context, Game game) =>
            const GameOverOverlay(),
      },
    );
  }
}
