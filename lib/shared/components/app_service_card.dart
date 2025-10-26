import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/domain/model/service_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const AppServiceCard({super.key, required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.gradientStart,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusRound,
                  ),
                ),
                child: service.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusRound,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: service.image!,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.handyman,
                            color: AppColors.primary,
                            size: 26.sp,
                          ),
                        ),
                      )
                    : Icon(
                        _getIconData(service.icon),
                        color: AppColors.primary,
                        size: 26.sp,
                      ),
              ),
              SizedBox(height: 6.h),
              Flexible(
                child: Text(
                  service.name,
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 10.sp),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    return switch (iconName.toLowerCase()) {
      'zap' => Icons.flash_on,
      'droplet' => Icons.water_drop,
      'wind' => Icons.ac_unit,
      'paintbrush' => Icons.format_paint,
      'home' => Icons.home_repair_service,
      'hammer' => Icons.handyman,
      'flame' => Icons.local_fire_department,
      'sparkles' => Icons.cleaning_services,
      _ => Icons.build,
    };
  }
}
