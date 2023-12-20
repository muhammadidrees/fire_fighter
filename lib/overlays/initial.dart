part of 'overlays.dart';

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
          SizedBox(height: 24),
          Text(
            'by @muhammadidrees',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(height: 36),
          Text(
            'Tap to use the fire engine to put out the fires',
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
            "Let's see how long you can keep the fire out :)",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'PressStart2P',
            ),
          ),
          SizedBox(height: 36),
          BlinkingText('Tap to start'),
        ],
      ),
    );
  }
}
