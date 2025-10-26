import 'package:base/domain/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/domain/model/user_model.dart';

/// Map Placeholder - Hiển thị bản đồ giả lập với worker pins
class MapPlaceholder extends StatelessWidget {
  final List<WorkerModel> workers;

  const MapPlaceholder({
    super.key,
    required this.workers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      color: AppColors.backgroundDark,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 48.w, color: AppColors.primary),
                SizedBox(height: 8.h),
                Text(
                  'Bản đồ hiển thị thợ trong bán kính 2km',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${workers.length} thợ được tìm thấy',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Worker pins on map
          ...workers.asMap().entries.map((entry) {
            final index = entry.key;
            final worker = entry.value;
            return Positioned(
              top: 30 + (index * 15).toDouble(),
              left: 20 + (index * 20).toDouble(),
              child: Stack(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.backgroundLight,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.textWhite,
                      size: 24.w,
                    ),
                  ),
                  if (worker.isOnline!)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.backgroundLight,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

