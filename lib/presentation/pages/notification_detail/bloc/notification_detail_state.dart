import 'package:equatable/equatable.dart';
import 'package:base/domain/model/notification_model.dart';

/// Trạng thái của màn Notification Detail
enum NotificationDetailStatus {
  initial,
  loading,
  success,
  deleted,
  failure,
}

/// State của Notification Detail BLoC
class NotificationDetailState extends Equatable {
  final NotificationDetailStatus status;
  final NotificationModel notification;
  final bool isRead;
  final String? errorMessage;

  const NotificationDetailState({
    this.status = NotificationDetailStatus.initial,
    required this.notification,
    required this.isRead,
    this.errorMessage,
  });

  NotificationDetailState copyWith({
    NotificationDetailStatus? status,
    NotificationModel? notification,
    bool? isRead,
    String? errorMessage,
  }) {
    return NotificationDetailState(
      status: status ?? this.status,
      notification: notification ?? this.notification,
      isRead: isRead ?? this.isRead,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, notification, isRead, errorMessage];

  @override
  bool get stringify => true;
}

