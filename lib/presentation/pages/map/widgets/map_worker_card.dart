import 'package:base/domain/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_avatar.dart';
import 'package:base/shared/components/app_badge.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:base/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Map Worker Card - Hiển thị thông tin worker
class MapWorkerCard extends StatelessWidget {
  final WorkerModel worker;

  const MapWorkerCard({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to worker detail
        context.push(AppRoutes.workerDetail, extra: worker);
      },
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAvatar(
              imageUrl: worker.avatar,
              name: worker.name,
              size: 64.w,
              showOnlineBadge: true,
              isOnline: worker.isOnline!,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          worker.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppBadge(
                        text: worker.isOnline!
                            ? 'Tôi đang rảnh'
                            : 'Tôi đang bận',
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
                      Icon(Icons.star, color: AppColors.rating, size: 16.w),
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
                        Icons.navigation,
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
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 4.w,
                    runSpacing: 4.h,
                    children: worker.skills!
                        .map(
                          (skill) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundDark,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusSM,
                              ),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(skill, style: AppTextStyles.caption),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
