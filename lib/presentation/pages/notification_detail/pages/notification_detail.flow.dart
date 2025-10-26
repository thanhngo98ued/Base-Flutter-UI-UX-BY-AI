import 'package:base/presentation/pages/notification_detail/bloc/bloc.dart';
import 'package:base/presentation/pages/notification_detail/pages/notification_detail.page.dart';
import 'package:base/domain/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Notification Detail Flow - Quản lý routing và dependencies
class NotificationDetailFlow {
  NotificationDetailFlow._();

  static const String path = '/notification-detail';
  static const String name = 'notification-detail';

  /// Tạo GoRoute cho Notification Detail
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        final notification = state.extra as NotificationModel;
        return MaterialPage(
          child: BlocProvider(
            create: (context) => NotificationDetailBloc(
              initialState: NotificationDetailState(
                notification: notification,
                isRead: notification.read,
              ),
            ),
            child: const NotificationDetailPage(),
          ),
        );
      },
    );
  }
}

