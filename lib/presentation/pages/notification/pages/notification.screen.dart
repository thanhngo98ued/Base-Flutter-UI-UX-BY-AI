import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/domain/model/notification_model.dart';
import 'package:base/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  final List<NotificationModel> notifications;
  final Function(String notificationId) onMarkAsRead;
  final VoidCallback onMarkAllAsRead;

  const NotificationScreen({
    super.key,
    required this.notifications,
    required this.onMarkAsRead,
    required this.onMarkAllAsRead,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _filter = 'all'; // 'all' or 'unread'

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('vi', timeago.ViMessages());
  }

  List<NotificationModel> get _filteredNotifications {
    if (_filter == 'unread') {
      return widget.notifications.where((n) => !n.read).toList();
    }
    return widget.notifications;
  }

  int get _unreadCount => widget.notifications.where((n) => !n.read).length;

  IconData _getNotificationIcon(NotificationType type) {
    return switch (type) {
      NotificationType.newJob => Icons.work,
      NotificationType.jobAccepted => Icons.check_circle,
      NotificationType.newMessage => Icons.message,
      NotificationType.adminAnnouncement => Icons.campaign,
      NotificationType.topUp => Icons.attach_money,
      NotificationType.systemUpdate => Icons.settings,
      NotificationType.newBranch => Icons.store,
    };
  }

  Color _getNotificationIconColor(NotificationType type) {
    return switch (type) {
      NotificationType.newJob => AppColors.info,
      NotificationType.jobAccepted => AppColors.success,
      NotificationType.newMessage => const Color(0xFF9333EA), // purple-600
      NotificationType.adminAnnouncement => AppColors.secondary,
      NotificationType.topUp => AppColors.success,
      NotificationType.systemUpdate => AppColors.textSecondary,
      NotificationType.newBranch => AppColors.error,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.backgroundLight,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.paddingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Thông báo', style: AppTextStyles.h2)],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFilterButton(
                            'all',
                            'Tất cả (${widget.notifications.length})',
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: _buildFilterButton(
                            'unread',
                            'Chưa đọc ($_unreadCount)',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Notification list
          Expanded(
            child: _filteredNotifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64.w,
                          color: AppColors.textTertiary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Không có thông báo nào',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: _filteredNotifications.length,
                    separatorBuilder: (context, index) =>
                        Divider(height: 1, color: AppColors.divider),
                    itemBuilder: (context, index) {
                      final notification = _filteredNotifications[index];
                      return InkWell(
                        onTap: () {
                          // Navigate to notification detail
                          context
                              .push(
                                AppRoutes.notificationDetail,
                                extra: notification,
                              )
                              .then((deleted) {
                                // If notification was deleted, mark as read in parent
                                if (deleted == true) {
                                  widget.onMarkAsRead(notification.id);
                                }
                              });
                        },
                        child: Container(
                          color: notification.read
                              ? AppColors.backgroundLight
                              : AppColors.gradientStart,
                          padding: EdgeInsets.all(AppDimensions.paddingMD),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundDark,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getNotificationIcon(notification.type),
                                  color: _getNotificationIconColor(
                                    notification.type,
                                  ),
                                  size: AppDimensions.iconLG,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            notification.title,
                                            style: AppTextStyles.bodyLarge
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        if (!notification.read)
                                          Container(
                                            width: 8.w,
                                            height: 8.h,
                                            decoration: const BoxDecoration(
                                              color: AppColors.primary,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      notification.message,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      timeago.format(
                                        notification.timestamp,
                                        locale: 'vi',
                                      ),
                                      style: AppTextStyles.caption,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String value, String label) {
    final isSelected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMD,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isSelected ? AppColors.textWhite : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
