import 'package:base/presentation/pages/notification/pages/notification.screen.dart';
import 'package:base/data/mock/mock_data.dart';
import 'package:flutter/material.dart';

/// Notification Page - wrapper
///
/// Chứa:
/// - Scaffold
/// - Load dữ liệu
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Load notifications từ BLoC/Repository thay vì MockData
    return NotificationScreen(
      notifications: MockData.notifications,
      onMarkAsRead: (id) {
        // TODO: Mark notification as read
      },
      onMarkAllAsRead: () {
        // TODO: Mark all as read
      },
    );
  }
}
