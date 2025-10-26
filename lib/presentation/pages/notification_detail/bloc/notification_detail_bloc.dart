import 'package:bloc/bloc.dart';

import 'notification_detail_event.dart';
import 'notification_detail_state.dart';

/// BLoC cho màn Notification Detail
class NotificationDetailBloc
    extends Bloc<NotificationDetailEvent, NotificationDetailState> {
  NotificationDetailBloc({required NotificationDetailState initialState})
      : super(initialState) {
    on<NotificationDetailMarkAsRead>(_onMarkAsRead);
    on<NotificationDetailDeleted>(_onDeleted);
    on<NotificationDetailActionClicked>(_onActionClicked);

    // Auto mark as read khi mở
    if (!initialState.isRead) {
      add(const NotificationDetailMarkAsRead());
    }
  }

  /// Handler: Mark as read
  Future<void> _onMarkAsRead(
    NotificationDetailMarkAsRead event,
    Emitter<NotificationDetailState> emit,
  ) async {
    try {
      // TODO: Call API to mark as read
      await Future.delayed(const Duration(milliseconds: 300));

      emit(state.copyWith(isRead: true));
    } catch (error) {
      emit(state.copyWith(
        status: NotificationDetailStatus.failure,
        errorMessage: 'Không thể đánh dấu đã đọc',
      ));
    }
  }

  /// Handler: Delete notification
  Future<void> _onDeleted(
    NotificationDetailDeleted event,
    Emitter<NotificationDetailState> emit,
  ) async {
    emit(state.copyWith(status: NotificationDetailStatus.loading));

    try {
      // TODO: Call API to delete
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(status: NotificationDetailStatus.deleted));
    } catch (error) {
      emit(state.copyWith(
        status: NotificationDetailStatus.failure,
        errorMessage: 'Không thể xóa thông báo',
      ));
    }
  }

  /// Handler: Action clicked
  Future<void> _onActionClicked(
    NotificationDetailActionClicked event,
    Emitter<NotificationDetailState> emit,
  ) async {
    // TODO: Handle different actions based on notification type
    print('Action clicked: ${event.action}');
  }
}

