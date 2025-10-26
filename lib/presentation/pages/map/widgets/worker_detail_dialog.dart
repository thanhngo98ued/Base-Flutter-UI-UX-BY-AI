import 'package:base/domain/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_avatar.dart';
import 'package:base/shared/components/app_badge.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:intl/intl.dart';

class WorkerDetailDialog extends StatelessWidget {
  final WorkerModel worker;
  final VoidCallback onChat;
  final VoidCallback onHire;

  const WorkerDetailDialog({
    super.key,
    required this.worker,
    required this.onChat,
    required this.onHire,
  });

  static Future<void> show(
    BuildContext context, {
    required WorkerModel worker,
    required VoidCallback onChat,
    required VoidCallback onHire,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WorkerDetailDialog(
        worker: worker,
        onChat: onChat,
        onHire: onHire,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusXL),
          topRight: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(AppDimensions.paddingLG),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.radiusXL),
                topRight: Radius.circular(AppDimensions.radiusXL),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thông tin thợ',
                  style: AppTextStyles.h3,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.backgroundDark,
                  ),
                  icon: Icon(
                    Icons.close,
                    size: AppDimensions.iconSM,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Worker info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppAvatar(
                        imageUrl: worker.avatar,
                        name: worker.name,
                        size: 80.w,
                        showOnlineBadge: true,
                        isOnline: worker.isOnline!,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    worker.name,
                                    style: AppTextStyles.h3,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                AppBadge(
                                  text: worker.isOnline! ? 'Tôi đang rảnh' : 'Tôi đang bận',
                                  type: worker.isOnline!
                                      ? AppBadgeType.success
                                      : AppBadgeType.error,
                                  isSmall: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColors.rating,
                                  size: 16.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  worker.rating!.toString(),
                                  style: AppTextStyles.bodySmall,
                                ),
                                SizedBox(width: 12.w),
                                Icon(
                                  Icons.work,
                                  color: AppColors.textSecondary,
                                  size: 16.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${worker.jobsCompleted} việc',
                                  style: AppTextStyles.bodySmall,
                                ),
                                SizedBox(width: 12.w),
                                Icon(
                                  Icons.location_on,
                                  color: AppColors.textSecondary,
                                  size: 16.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${worker.distance}km',
                                  style: AppTextStyles.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Skills
                  _buildSection(
                    'Kỹ năng',
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: worker.skills!
                          .map(
                            (skill) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundLight,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusSM,
                                ),
                                border: Border.all(
                                  color: AppColors.border,
                                ),
                              ),
                              child: Text(
                                skill,
                                style: AppTextStyles.bodySmall,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Price
                  _buildSection(
                    'Giá dịch vụ',
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: AppColors.primary,
                          size: AppDimensions.iconSM,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${NumberFormat('#,###', 'vi_VN').format(worker.hourlyRate)}đ/giờ',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Contact
                  _buildSection(
                    'Thông tin liên hệ',
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: AppColors.textSecondary,
                          size: 16.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          worker.phone,
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Working hours
                  _buildSection(
                    'Thời gian hoạt động',
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.textSecondary,
                          size: 16.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Thứ 2 - Chủ nhật: 7:00 - 20:00',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Nhắn tin',
                          onPressed: () {
                            Navigator.pop(context);
                            onChat();
                          },
                          type: AppButtonType.outline,
                          icon: Icon(
                            Icons.message,
                            size: AppDimensions.iconSM,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: AppButton(
                          text: 'Thuê ngay',
                          onPressed: () {
                            Navigator.pop(context);
                            onHire();
                          },
                          icon: Icon(
                            Icons.work,
                            color: AppColors.textWhite,
                            size: AppDimensions.iconSM,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, {required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }
}

