import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/shared/components/app_avatar.dart';
import 'package:base/shared/components/app_cancel_job_dialog.dart';
import 'package:base/domain/model/job_model.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:go_router/go_router.dart';

/// Job Detail Screen - Chi tiết công việc
class JobDetailScreen extends StatelessWidget {
  final JobModel job;
  final UserModel? worker;
  final VoidCallback? onRateJob;
  final VoidCallback? onCancelJob;
  final VoidCallback? onAcceptJob;
  final VoidCallback? onRejectJob;

  const JobDetailScreen({
    super.key,
    required this.job,
    this.worker,
    this.onRateJob,
    this.onCancelJob,
    this.onAcceptJob,
    this.onRejectJob,
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
        title: const Text('Chi tiết công việc'),
        actions: [
          if (job.status == JobStatus.completed && onRateJob != null)
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: onRateJob,
              tooltip: 'Đánh giá',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Status Card
            _buildStatusCard(),
            SizedBox(height: 24.h),

            // Job Info Card
            _buildJobInfoCard(),
            SizedBox(height: 24.h),

            // Worker Info Card (if worker assigned)
            if (worker != null) ...[
              _buildWorkerInfoCard(),
              SizedBox(height: 24.h),
            ],

            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
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
        children: [
          Row(
            children: [
              Icon(_getStatusIcon(), color: _getStatusColor(), size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStatusText(),
                      style: AppTextStyles.h3.copyWith(
                        color: _getStatusColor(),
                      ),
                    ),
                    Text(
                      _getStatusDescription(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Ngày tạo: ${_formatDate(job.createdAt)}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
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
          _buildInfoRow('Dịch vụ', job.category),
          _buildInfoRow('Mô tả', job.description),
          _buildInfoRow('Địa chỉ', job.address),
          _buildInfoRow('Thời gian', _formatDateTime(job.createdAt)),
          _buildInfoRow(
            'Đơn giá',
            '${job.price?.toStringAsFixed(0) ?? '0'} VNĐ',
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerInfoCard() {
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
          Text('Thông tin thợ', style: AppTextStyles.h3),
          SizedBox(height: 16.h),
          Row(
            children: [
              AppAvatar(
                imageUrl: '',
                name: worker!.name,
                size: 60.w,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(worker!.name, style: AppTextStyles.bodyLarge),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          ' 0.0',
                          style: AppTextStyles.bodyMedium,
                        ),
                        SizedBox(width: 16.w),
                        Icon(Icons.work, color: AppColors.primary, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          '250 công việc',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (job.status == JobStatus.findingWorker && onCancelJob != null)
          Builder(
            builder: (context) => AppButton(
              text: 'Hủy công việc',
              onPressed: () => _showCancelJobDialog(context),
              type: AppButtonType.outline,
              backgroundColor: AppColors.error,
              textColor: AppColors.error,
            ),
          ),

        if (job.status == JobStatus.waitingConfirmation && onAcceptJob != null)
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Từ chối',
                  onPressed: onRejectJob,
                  type: AppButtonType.outline,
                  backgroundColor: AppColors.error,
                  textColor: AppColors.error,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: AppButton(text: 'Chấp nhận', onPressed: onAcceptJob),
              ),
            ],
          ),

        if (job.status == JobStatus.completed && onRateJob != null)
          AppButton(
            text: 'Đánh giá công việc',
            onPressed: onRateJob,
            icon: Icon(
              Icons.star,
              color: AppColors.textWhite,
              size: AppDimensions.iconSM,
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(child: Text(value, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (job.status) {
      case JobStatus.findingWorker:
        return Icons.search;
      case JobStatus.waitingConfirmation:
        return Icons.schedule;
      case JobStatus.inProgress:
        return Icons.work;
      case JobStatus.completed:
        return Icons.check_circle;
      case JobStatus.cancelled:
        return Icons.cancel;
      case JobStatus.rejected:
        return Icons.close;
    }
  }

  Color _getStatusColor() {
    switch (job.status) {
      case JobStatus.findingWorker:
        return AppColors.warning;
      case JobStatus.waitingConfirmation:
        return AppColors.primary;
      case JobStatus.inProgress:
        return AppColors.info;
      case JobStatus.completed:
        return AppColors.success;
      case JobStatus.cancelled:
      case JobStatus.rejected:
        return AppColors.error;
    }
  }

  String _getStatusText() {
    switch (job.status) {
      case JobStatus.findingWorker:
        return 'Đang tìm thợ';
      case JobStatus.waitingConfirmation:
        return 'Đang chờ xác nhận';
      case JobStatus.inProgress:
        return 'Đã nhận việc';
      case JobStatus.completed:
        return 'Đã hoàn thành';
      case JobStatus.cancelled:
        return 'Đã huỷ bỏ';
      case JobStatus.rejected:
        return 'Đã từ chối';
    }
  }

  String _getStatusDescription() {
    switch (job.status) {
      case JobStatus.findingWorker:
        return 'Hệ thống đang tìm thợ phù hợp cho công việc của bạn';
      case JobStatus.waitingConfirmation:
        return 'Thợ đã nhận công việc, đang chờ xác nhận';
      case JobStatus.inProgress:
        return 'Thợ đang thực hiện công việc';
      case JobStatus.completed:
        return 'Công việc đã hoàn thành thành công';
      case JobStatus.cancelled:
        return 'Công việc đã bị huỷ bỏ';
      case JobStatus.rejected:
        return 'Thợ đã từ chối công việc';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showCancelJobDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppCancelJobDialog(
        jobTitle: job.title,
        onConfirm: (reason) async {
          // TODO: Call API to cancel job with reason
          await Future.delayed(const Duration(seconds: 1)); // Simulate API call
          
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Công việc "${job.title}" đã được hủy'),
                backgroundColor: Colors.orange,
                action: SnackBarAction(
                  label: 'Xem lý do',
                  textColor: Colors.white,
                  onPressed: () {
                    // Show reason in a simple dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Lý do hủy'),
                        content: Text(reason),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Đóng'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
            Navigator.of(context).pop(); // Close job detail screen
          }
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}
