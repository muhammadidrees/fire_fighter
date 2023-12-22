part of 'utils.dart';

class Assets {
  Assets._();

  static const images = ImageAssets._();
  static const audio = AudioAssets._();
}

class ImageAssets {
  const ImageAssets._();

  List<String> get all => [
        ...fireAnimation,
        ...fireEngineAnimation,
      ];

  List<String> get fireEngineAnimation =>
      List.generate(2, (i) => 'fire_engine/sprite_engine$i.png');

  List<String> get fireAnimation =>
      List.generate(6, (i) => 'fire/sprite_fire$i.png');
}

class AudioAssets {
  const AudioAssets._();

  List<String> get all => [
        background,
      ];

  String get background => 'background_music.mp3';
}
