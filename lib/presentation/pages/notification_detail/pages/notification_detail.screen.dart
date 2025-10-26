import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/domain/model/notification_model.dart';
import 'package:base/presentation/pages/notification_detail/bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Notification Detail Screen - Chi tiết thông báo
class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({super.key});

  IconData _getNotificationIcon(NotificationType type) {
    return switch (type) {
      NotificationType.newJob => Icons.work,
      NotificationType.jobAccepted => Icons.check_circle,
      NotificationType.newMessage => Icons.message,
      NotificationType.adminAnnouncement => Icons.campaign,
      NotificationType.topUp => Icons.account_balance_wallet,
      NotificationType.systemUpdate => Icons.system_update,
      NotificationType.newBranch => Icons.store,
    };
  }

  Color _getNotificationColor(NotificationType type) {
    return switch (type) {
      NotificationType.newJob => AppColors.primary,
      NotificationType.jobAccepted => AppColors.success,
      NotificationType.newMessage => AppColors.secondary,
      NotificationType.adminAnnouncement => AppColors.warning,
      NotificationType.topUp => AppColors.success,
      NotificationType.systemUpdate => AppColors.info,
      NotificationType.newBranch => AppColors.primary,
    };
  }

  String _getActionButtonText(NotificationType type) {
    return switch (type) {
      NotificationType.newJob => 'Xem công việc',
      NotificationType.jobAccepted => 'Xem chi tiết',
      NotificationType.newMessage => 'Mở tin nhắn',
      NotificationType.adminAnnouncement => 'Xem thêm',
      NotificationType.topUp => 'Xem lịch sử',
      NotificationType.systemUpdate => 'Cập nhật ngay',
      NotificationType.newBranch => 'Tìm hiểu thêm',
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationDetailBloc, NotificationDetailState>(
      builder: (context, state) {
        final notification = state.notification;
        final notificationColor = _getNotificationColor(notification.type);
        final notificationIcon = _getNotificationIcon(notification.type);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundLight,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.textPrimary,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Chi tiết thông báo',
              style: AppTextStyles.h3,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                ),
                onPressed: () {
                  _showDeleteConfirmation(context);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Icon và Type
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppDimensions.paddingXL),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: notificationColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          notificationIcon,
                          size: 40.sp,
                          color: notificationColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        notification.title,
                        style: AppTextStyles.h2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        timeago.format(notification.timestamp, locale: 'vi'),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Content
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLG,
                  ),
                  padding: EdgeInsets.all(AppDimensions.paddingLG),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusLG,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nội dung',
                        style: AppTextStyles.h4,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        notification.message,
                        style: AppTextStyles.bodyMedium.copyWith(
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Action buttons
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLG,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<NotificationDetailBloc>()
                                .add(NotificationDetailActionClicked(
                                  _getActionButtonText(notification.type),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: notificationColor,
                            foregroundColor: AppColors.textWhite,
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMD,
                              ),
                            ),
                          ),
                          child: Text(
                            _getActionButtonText(notification.type),
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: BorderSide(
                              color: AppColors.border,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMD,
                              ),
                            ),
                          ),
                          child: Text(
                            'Đóng',
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Xóa thông báo', style: AppTextStyles.h3),
        content: Text(
          'Bạn có chắc muốn xóa thông báo này?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Hủy',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context
                  .read<NotificationDetailBloc>()
                  .add(const NotificationDetailDeleted());
            },
            child: Text(
              'Xóa',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

