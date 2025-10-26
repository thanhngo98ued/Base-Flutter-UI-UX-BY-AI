import 'package:equatable/equatable.dart';

class PageState<T> extends Equatable {
  const PageState._({
    required this.uiState,
    this.isLoading = false,
    this.exception,
  });

  factory PageState.initial(T uiState) {
    return PageState._(uiState: uiState);
  }

  final T uiState;
  final bool isLoading;
  final Object? exception;

  PageState<T> copyWith({
    T? uiState,
    bool? isLoading,
    Object? exception,
  }) {
    return PageState<T>._(
      uiState: uiState ?? this.uiState,
      isLoading: isLoading ?? this.isLoading,
      exception: exception,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [uiState, isLoading, exception];
}
