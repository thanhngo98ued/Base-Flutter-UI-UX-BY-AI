import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class PriceTableItem {
  final String service;
  final int minPrice;
  final int maxPrice;
  final String unit;

  const PriceTableItem({
    required this.service,
    required this.minPrice,
    required this.maxPrice,
    required this.unit,
  });
}

/// PriceTable Screen - Content chính của màn Bảng giá
/// 
/// Nhiệm vụ:
/// - Hiển thị bảng giá dịch vụ
/// - Navigation được xử lý trực tiếp
class PriceTableScreen extends StatelessWidget {
  final List<PriceTableItem> priceTable;

  const PriceTableScreen({
    super.key,
    required this.priceTable,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Bảng giá tham khảo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          children: [
            // Header card
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primaryDark,
                  ],
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: AppColors.textWhite,
                        size: 32.w,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Giá dịch vụ',
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.textWhite,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Bảng giá dưới đây chỉ mang tính chất tham khảo. Giá thực tế có thể thay đổi tùy theo mức độ phức tạp của công việc.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textWhite.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Price list
            ...priceTable.map((item) => _buildPriceItem(item)),
            SizedBox(height: 16.h),
            // Note card
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                border: Border.all(
                  color: AppColors.warning.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lưu ý',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: const Color(0xFFB45309), // yellow-700
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildNoteItem('Giá có thể thay đổi tùy theo khu vực'),
                  SizedBox(height: 4.h),
                  _buildNoteItem('Phí di chuyển có thể được tính thêm'),
                  SizedBox(height: 4.h),
                  _buildNoteItem('Giá cuối cùng sẽ được thỏa thuận với thợ'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceItem(PriceTableItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.service,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                child: Text(
                  'Đơn vị: ${item.unit}',
                  style: AppTextStyles.caption,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giá từ:',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Row(
                children: [
                  Text(
                    NumberFormat('#,###', 'vi_VN').format(item.minPrice),
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'đ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      '-',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  Text(
                    NumberFormat('#,###', 'vi_VN').format(item.maxPrice),
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'đ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h, right: 8.w),
          child: Container(
            width: 4.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFFB45309), // yellow-700
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: const Color(0xFFB45309), // yellow-700
            ),
          ),
        ),
      ],
    );
  }
}

