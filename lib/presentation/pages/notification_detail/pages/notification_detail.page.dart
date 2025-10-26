import 'package:base/presentation/pages/notification_detail/pages/notification_detail.screen.dart';
import 'package:base/presentation/pages/notification_detail/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Notification Detail Page - wrapper với dependencies và navigation handling
class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationDetailBloc, NotificationDetailState>(
      listener: (context, state) {
        if (state.status == NotificationDetailStatus.deleted) {
          // Navigate back khi xóa thành công
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã xóa thông báo'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
            ),
          );
          context.pop(true); // Return true to indicate deleted
        } else if (state.status == NotificationDetailStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Đã xảy ra lỗi'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: const NotificationDetailScreen(),
    );
  }
}

