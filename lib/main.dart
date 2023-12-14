import 'package:fire_fighter/game/game.dart';
import 'package:fire_fighter/overlays/overlays.dart';
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

  final game = FireFighterGame();

  runApp(
    GameWidget(
      game: game,
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
