import 'dart:async';

import 'package:base/presentation/base/page_state.dart';
import 'package:flutter/material.dart';

mixin BaseStateMixin<UiState> {
  int _loadingCount = 0;

  PageState<UiState> get currentState;
  
  void emitState(PageState<UiState> state);

  UiState get uiState => currentState.uiState;

  void emitUiState(UiState uiState) {
    emitState(currentState.copyWith(uiState: uiState, exception: null));
  }

  void emitError(Object error) {
    emitState(currentState.copyWith(exception: error));
  }

  void showLoading() {
    if (_loadingCount == 0) {
      emitState(currentState.copyWith(isLoading: true));
    }
    _loadingCount++;
  }

  void hideLoading() {
    _loadingCount--;
    if (_loadingCount == 0) {
      emitState(currentState.copyWith(isLoading: false));
    }
  }

  void clearError() {
    emitState(currentState.copyWith(exception: null));
  }

  Future<void> runCatching({
    required FutureOr<void> Function() action,
    bool handleLoading = true,
    bool handleError = true,
    VoidCallback? doOnLoading,
    Function(Object)? doOnError,
    VoidCallback? doOnSuccess,
  }) async {
    try {
      if (handleLoading) {
        showLoading();
      }
      doOnLoading?.call();
      await action();
      doOnSuccess?.call();
    } on Object catch (e) {
      if (handleError) {
        emitError(e);
      }
      doOnError?.call(e);
    } finally {
      if (handleLoading) {
        hideLoading();
      }
    }
  }
}

