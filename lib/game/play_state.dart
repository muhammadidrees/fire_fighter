part of 'game.dart';

enum GameState {
  welcome,
  playing,
  gameOver,
}

class GameStateManager {
  GameState _state = GameState.welcome;

  GameState get state => _state;

  bool get isPlaying => _state == GameState.playing;

  bool get isGameOver => _state == GameState.gameOver;

  bool get isWelcome => _state == GameState.welcome;

  set state(GameState newState) {
    _state = newState;
    _stateChangeController.add(newState);
  }

  final _stateChangeController = StreamController<GameState>.broadcast();

  Stream<GameState> get onStateChange => _stateChangeController.stream;

  void dispose() {
    _stateChangeController.close();
  }
}
