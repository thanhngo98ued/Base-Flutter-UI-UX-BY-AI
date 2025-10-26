import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_service_card.dart';
import 'package:base/shared/components/app_banner_carousel.dart';
import 'package:base/domain/model/service_model.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:base/shared/extensions/context_ext.dart';

class ServiceHomeScreen extends StatefulWidget {
  final int notificationCount;
  final VoidCallback onNotificationClick;
  final Function(String serviceId) onServiceClick;
  final List<BannerModel> banners;
  final List<ServiceModel> services;
  final UserModel currentUser;
  final VoidCallback? onAvailabilityToggle;
  final bool? isAvailable; // Current availability state
  final VoidCallback? onSearchClick; // Callback when search is clicked

  const ServiceHomeScreen({
    super.key,
    required this.notificationCount,
    required this.onNotificationClick,
    required this.onServiceClick,
    required this.banners,
    required this.services,
    required this.currentUser,
    this.onAvailabilityToggle,
    this.isAvailable,
    this.onSearchClick,
  });

  @override
  State<ServiceHomeScreen> createState() => _ServiceHomeScreenState();
}

class _ServiceHomeScreenState extends State<ServiceHomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLG,
                  vertical: 12.h,
                ),
                child: Column(
                  children: [
                    // Top bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.l10n?.callWorkerTranThi ?? '',
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Stack(
                          children: [
                            IconButton(
                              onPressed: widget.onNotificationClick,
                              padding: EdgeInsets.all(8.w),
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                Icons.notifications_outlined,
                                color: AppColors.textWhite,
                                size: 24.sp,
                              ),
                            ),
                            if (widget.notificationCount > 0)
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  decoration: const BoxDecoration(
                                    color: AppColors.badgeRed,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16.w,
                                    minHeight: 16.w,
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.notificationCount > 99
                                          ? '99+'
                                          : widget.notificationCount.toString(),
                                      style: AppTextStyles.captionBold.copyWith(
                                        color: AppColors.textWhite,
                                        fontSize: 9.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Search bar for customers, Availability switch for workers
                    if (widget.currentUser.role == UserRole.customer) ...[
                      GestureDetector(
                        onTap: widget.onSearchClick,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMD,
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: AppColors.textTertiary,
                                size: 20.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Tìm thợ...',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      // Availability switch for workers
                      Container(
                        padding: EdgeInsets.all(AppDimensions.paddingMD),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMD,
                          ),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              (widget.isAvailable ?? true) == true
                                  ? Icons.check_circle
                                  : Icons.pause_circle,
                              color: (widget.isAvailable ?? true) == true
                                  ? AppColors.success
                                  : AppColors.textSecondary,
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (widget.isAvailable ?? true) == true
                                        ? 'Tôi đang rảnh'
                                        : 'Tôi đang bận',
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          (widget.isAvailable ?? true) == true
                                          ? AppColors.success
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    'Trạng thái của bạn',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: widget.isAvailable ?? true,
                              onChanged: (value) {
                                if (widget.onAvailabilityToggle != null) {
                                  widget.onAvailabilityToggle!();
                                }
                              },
                              activeColor: AppColors.success,
                              activeTrackColor: AppColors.success.withOpacity(
                                0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.currentUser.role == UserRole.customer) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingLG,
                          ).copyWith(top: 24.h),
                          child: Text('Dịch vụ', style: AppTextStyles.h3),
                        ),
                        SizedBox(height: 16.h),
                        // Grid 2 hàng scroll ngang
                        SizedBox(
                          height: 200.h,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingLG,
                              vertical: 8.h,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12.w,
                                  crossAxisSpacing: 12.h,
                                  childAspectRatio: 1.1,
                                ),
                            itemCount: widget.services.length,
                            itemBuilder: (context, index) {
                              final service = widget.services[index];
                              return AppServiceCard(
                                service: service,
                                onTap: () => widget.onServiceClick(service.id),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 24.h),
                  // Contact cards
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingLG,
                    ),
                    child: AppBannerCarousel(
                      banners: widget.banners,
                      height: 140.h,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingLG,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildContactCard(
                            icon: Icons.language,
                            iconColor: AppColors.primary,
                            iconBgColor: AppColors.gradientStart,
                            title: 'Website',
                            subtitle: 'tranthi.vn',
                            onTap: () {
                              // Open website
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildContactCard(
                            icon: Icons.phone,
                            iconColor: AppColors.success,
                            iconBgColor: AppColors.success.withOpacity(0.1),
                            title: 'Liên hệ',
                            subtitle: '1900xxxx',
                            onTap: () {
                              // Open phone
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Guide card
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingLG,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(AppDimensions.paddingLG),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.secondary,
                            AppColors.secondaryDark,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusLG,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hướng dẫn sử dụng',
                            style: AppTextStyles.h4.copyWith(
                              color: AppColors.textWhite,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Tìm hiểu cách sử dụng ứng dụng để tìm thợ nhanh chóng và hiệu quả',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textWhite.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () {
                              // Show guide
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.backgroundLight,
                              foregroundColor: AppColors.secondary,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLG,
                                vertical: 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusMD,
                                ),
                              ),
                            ),
                            child: Text(
                              'Xem hướng dẫn',
                              style: AppTextStyles.button,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
              child: Icon(icon, color: iconColor, size: AppDimensions.iconSM),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodySmall),
                  Text(
                    subtitle,
                    style: AppTextStyles.captionBold.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
