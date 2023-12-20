part of 'overlays.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Game Over!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Thank you for playing the game',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(height: 16),
          Text(
            'This game was created using Flutter and Flame\n\n'
            'for the contest Flame Jam 3.0.\n\n\n'
            'You can get the source code from:\n\nhttps://www.github.com/muhammadidrees/fire_fighter',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(height: 24),
          BlinkingText('Tap to play again :)'),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
