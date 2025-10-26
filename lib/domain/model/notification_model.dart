import 'package:equatable/equatable.dart';

enum NotificationType {
  newJob,
  jobAccepted,
  newMessage,
  adminAnnouncement,
  topUp,
  systemUpdate,
  newBranch,
}

class NotificationModel extends Equatable {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool read;
  final Map<String, dynamic>? data;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.read,
    this.data,
  });

  NotificationModel copyWith({
    String? id,
    String? userId,
    NotificationType? type,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? read,
    Map<String, dynamic>? data,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      read: read ?? this.read,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [id, userId, type, title, message, timestamp, read, data];
}

