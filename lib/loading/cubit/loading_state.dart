part of 'loading_cubit.dart';

/// State for [LoadingCubit].
class LoadingState extends Equatable {
  /// Create a [LoadingState] with initial conditions.
  const LoadingState.initial()
      : totalCount = 0,
        loadedCount = 0,
        currentLabel = '';

  const LoadingState._(
    this.loadedCount,
    this.currentLabel,
    this.totalCount,
  );

  /// The total count of load phases to be completed
  final int totalCount;

  /// The count of load phases that were completed so far
  final int loadedCount;

  /// A description of what is being loaded
  final String currentLabel;

  double get progress => totalCount == 0 ? 0 : loadedCount / totalCount;

  bool get isComplete => progress == 1.0;

  @override
  List<Object?> get props => [
        totalCount,
        loadedCount,
        currentLabel,
      ];

  LoadingState copyWith({
    int? loadedCount,
    String? currentLabel,
    int? totalCount,
  }) {
    return LoadingState._(
      loadedCount ?? this.loadedCount,
      currentLabel ?? this.currentLabel,
      totalCount ?? this.totalCount,
    );
  }
}
