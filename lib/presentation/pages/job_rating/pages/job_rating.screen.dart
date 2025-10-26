import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/shared/components/app_input_field.dart';
import 'package:base/domain/model/job_model.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:go_router/go_router.dart';

/// Job Rating Screen - Đánh giá công việc
class JobRatingScreen extends StatefulWidget {
  final JobModel job;
  final UserModel worker;

  const JobRatingScreen({super.key, required this.job, required this.worker});

  @override
  State<JobRatingScreen> createState() => _JobRatingScreenState();
}

class _JobRatingScreenState extends State<JobRatingScreen> {
  int _selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _handleSubmitRating() async {
    if (_selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn số sao đánh giá'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Call API to submit rating
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đánh giá đã được gửi thành công'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Đánh giá công việc'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Info Card
            _buildJobInfoCard(),
            SizedBox(height: 24.h),

            // Rating Section
            _buildRatingSection(),
            SizedBox(height: 24.h),

            // Comment Section
            _buildCommentSection(),
            SizedBox(height: 32.h),

            // Submit Button
            AppButton(
              text: 'Gửi đánh giá',
              onPressed: _handleSubmitRating,
              isLoading: _isLoading,
              icon: Icon(
                Icons.star,
                color: AppColors.textWhite,
                size: AppDimensions.iconSM,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
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
          Text('Thông tin công việc', style: AppTextStyles.h3),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.work, color: AppColors.primary, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  widget.job.category,
                  style: AppTextStyles.bodyLarge,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.person, color: AppColors.textSecondary, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Thợ: ${widget.worker.name}',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppColors.textSecondary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Hoàn thành: ${_formatDate(widget.job.completedAt ?? widget.job.createdAt)}',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
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
          Text('Đánh giá chất lượng', style: AppTextStyles.h3),
          SizedBox(height: 8.h),
          Text(
            'Bạn hài lòng với chất lượng công việc như thế nào?',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = starIndex;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(
                      starIndex <= _selectedRating
                          ? Icons.star
                          : Icons.star_border,
                      color: starIndex <= _selectedRating
                          ? Colors.amber
                          : AppColors.textTertiary,
                      size: 40.sp,
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 16.h),
          Center(
            child: Text(
              _getRatingText(),
              style: AppTextStyles.bodyLarge.copyWith(
                color: _selectedRating > 0
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
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
          Text('Nhận xét thêm', style: AppTextStyles.h3),
          SizedBox(height: 8.h),
          Text(
            'Chia sẻ thêm về trải nghiệm của bạn (tùy chọn)',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          AppInputField(
            controller: _commentController,
            hint:
                'Ví dụ: Thợ làm việc rất chuyên nghiệp, hoàn thành đúng hẹn...',
            maxLines: 6,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  String _getRatingText() {
    switch (_selectedRating) {
      case 1:
        return 'Rất không hài lòng';
      case 2:
        return 'Không hài lòng';
      case 3:
        return 'Bình thường';
      case 4:
        return 'Hài lòng';
      case 5:
        return 'Rất hài lòng';
      default:
        return 'Chọn số sao đánh giá';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
