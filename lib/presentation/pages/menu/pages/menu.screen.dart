import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_avatar.dart';
import 'package:base/shared/components/app_confirm_dialog.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  final UserModel currentUser;
  final VoidCallback onProfileClick;
  final VoidCallback onPriceTableClick;
  final VoidCallback onLogout;

  const MenuScreen({
    super.key,
    required this.currentUser,
    required this.onProfileClick,
    required this.onPriceTableClick,
    required this.onLogout,
  });

  Future<void> _openBrowser() async {
    final Uri url = Uri.parse('https://google.com');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Handle error if can't launch URL
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      MenuItem(
        icon: Icons.person,
        label: 'Hồ sơ cá nhân',
        onTap: onProfileClick,
        color: AppColors.primary,
        bgColor: AppColors.gradientStart,
      ),
      MenuItem(
        icon: Icons.shopping_bag,
        label: 'Cửa hàng trực tuyến',
        onTap: () {},
        color: AppColors.secondary,
        bgColor: AppColors.secondaryLight.withOpacity(0.2),
      ),
      MenuItem(
        icon: Icons.attach_money,
        label: 'Bảng giá tham khảo',
        onTap: onPriceTableClick,
        color: AppColors.success,
        bgColor: AppColors.success.withOpacity(0.1),
      ),
      MenuItem(
        icon: Icons.warning_amber_rounded,
        label: 'Khuyến Cáo',
        onTap: _openBrowser,
        color: AppColors.warning,
        bgColor: AppColors.warning.withOpacity(0.1),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header
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
                padding: EdgeInsets.all(AppDimensions.paddingLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: AppTextStyles.h2.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        AppAvatar(
                          imageUrl: '',
                          name: currentUser.name,
                          size: 64.w,
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentUser.name,
                                style: AppTextStyles.h4.copyWith(
                                  color: AppColors.textWhite,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                currentUser.phoneNumber,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textWhite.withOpacity(0.9),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // Balance display - only for workers
                              if (currentUser.role == UserRole.worker) ...[
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.textWhite.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSM,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.account_balance_wallet,
                                            color: AppColors.textWhite,
                                            size: 16.sp,
                                          ),
                                          SizedBox(width: 6.w),
                                          Text(
                                            '100.000 VND',
                                            style: AppTextStyles.bodyMedium.copyWith(
                                              color: AppColors.textWhite,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    // Deposit button
                                    InkWell(
                                      onTap: () => context.push('/deposit'),
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusSM,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.textWhite,
                                          borderRadius: BorderRadius.circular(
                                            AppDimensions.radiusSM,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: AppColors.primary,
                                              size: 16.sp,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              'Nộp tiền',
                                              style: AppTextStyles.bodySmall.copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
          // Menu items
          Transform.translate(
            offset: Offset(0, -16.h),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLG,
              ),
              child: Column(
                children: [
                  ...menuItems.map((item) => _buildMenuItem(item)),
                  // Logout button
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
            child: _buildMenuItem(
              MenuItem(
                icon: Icons.logout,
                label: 'Đăng xuất',
                onTap: onLogout,
                color: AppColors.error,
                bgColor: AppColors.error.withOpacity(0.1),
                isLogout: true,
              ),
            ),
          ),
          SizedBox(height: 16.w),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: item.bgColor,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusRound,
                    ),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.color,
                    size: AppDimensions.iconSM,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    item.label,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: item.isLogout
                          ? AppColors.error
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textTertiary,
                  size: AppDimensions.iconSM,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final Color bgColor;
  final bool isLogout;

  MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
    required this.bgColor,
    this.isLogout = false,
  });
}
