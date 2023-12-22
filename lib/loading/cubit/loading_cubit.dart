import 'package:equatable/equatable.dart';
import 'package:fire_fighter/utils/utils.dart';
import 'package:flame/cache.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit(
    this.images,
    this.audio,
  ) : super(const LoadingState.initial());

  final Images images;
  final AudioCache audio;

  Future<void> loadSequentially() async {
    final phases = [
      PreloadPhase(
        'audio',
        () => audio.loadAll(Assets.audio.all),
      ),
      PreloadPhase(
        'images',
        () => images.loadAll(Assets.images.all),
      ),
    ];

    emit(state.copyWith(totalCount: phases.length));
    for (final phase in phases) {
      emit(state.copyWith(currentLabel: phase.label));
      // Throttle phases to take at least 1/5 seconds
      await Future.wait([
        Future.delayed(Duration.zero, phase.start),
        Future<void>.delayed(const Duration(milliseconds: 200)),
      ]);
      emit(state.copyWith(loadedCount: state.loadedCount + 1));
    }
  }
}

@immutable
class PreloadPhase {
  const PreloadPhase(this.label, this.start);

  final String label;
  final ValueGetter<Future<void>> start;
}
