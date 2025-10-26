import 'package:equatable/equatable.dart';

/// Base event cho Notification Detail
abstract class NotificationDetailEvent extends Equatable {
  const NotificationDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Event: Mark notification as read
class NotificationDetailMarkAsRead extends NotificationDetailEvent {
  const NotificationDetailMarkAsRead();
}

/// Event: Delete notification
class NotificationDetailDeleted extends NotificationDetailEvent {
  const NotificationDetailDeleted();
}

/// Event: Action button clicked
class NotificationDetailActionClicked extends NotificationDetailEvent {
  final String action;

  const NotificationDetailActionClicked(this.action);

  @override
  List<Object?> get props => [action];
}

