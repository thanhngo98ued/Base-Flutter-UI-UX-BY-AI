import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_badge.dart';
import 'package:base/domain/model/job_model.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:base/presentation/pages/job_detail/pages/job_detail.screen.dart';
import 'package:base/presentation/pages/job_rating/pages/job_rating.screen.dart';
import 'package:base/shared/components/app_cancel_job_dialog.dart';
import 'package:base/data/mock/mock_data.dart';
import 'package:intl/intl.dart';

/// JobHistory Screen - Content chính của màn Lịch sử công việc
///
/// Nhiệm vụ:
/// - Hiển thị danh sách công việc
/// - Navigation được xử lý trực tiếp
class JobHistoryScreen extends StatelessWidget {
  final List<JobModel> jobs;

  const JobHistoryScreen({super.key, required this.jobs});

  String _getStatusText(JobStatus status) {
    return switch (status) {
      JobStatus.findingWorker => 'Đang tìm thợ',
      JobStatus.waitingConfirmation => 'Đang chờ xác nhận',
      JobStatus.inProgress => 'Đã nhận việc',
      JobStatus.completed => 'Đã hoàn thành',
      JobStatus.cancelled => 'Đã huỷ bỏ',
      JobStatus.rejected => 'Đã từ chối',
    };
  }

  AppBadgeType _getStatusBadgeType(JobStatus status) {
    return switch (status) {
      JobStatus.findingWorker => AppBadgeType.warning,
      JobStatus.waitingConfirmation => AppBadgeType.primary,
      JobStatus.inProgress => AppBadgeType.info,
      JobStatus.completed => AppBadgeType.success,
      JobStatus.cancelled => AppBadgeType.error,
      JobStatus.rejected => AppBadgeType.error,
    };
  }

  void _navigateToJobDetail(BuildContext context, JobModel job) {
    // Find worker for this job (mock data)
    UserModel? worker;
    if (job.workerId != null) {
      // worker = MockData.workers.firstWhere(
      //   (w) => w.id == job.workerId,
      //   orElse: () => MockData.workers.first,
      // );
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => JobDetailScreen(
          job: job,
          worker: worker,
          onRateJob: job.status == JobStatus.completed
              ? () => _navigateToRating(context, job, worker!)
              : null,
          onCancelJob: job.status == JobStatus.findingWorker
              ? () => _handleCancelJob(context, job)
              : null,
          onAcceptJob: job.status == JobStatus.waitingConfirmation
              ? () => _handleAcceptJob(context, job)
              : null,
          onRejectJob: job.status == JobStatus.waitingConfirmation
              ? () => _handleRejectJob(context, job)
              : null,
        ),
      ),
    );
  }

  void _navigateToRating(BuildContext context, JobModel job, UserModel worker) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => JobRatingScreen(job: job, worker: worker),
      ),
    );
  }

  void _handleCancelJob(BuildContext context, JobModel job) {
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
          }
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _handleAcceptJob(BuildContext context, JobModel job) {
    // TODO: Implement accept job logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã chấp nhận công việc'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  }

  void _handleRejectJob(BuildContext context, JobModel job) {
    // TODO: Implement reject job logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã từ chối công việc'),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Lịch sử công việc')),
      body: jobs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_outline,
                    size: 64.w,
                    color: AppColors.textTertiary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Chưa có công việc nào',
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Các công việc của bạn sẽ hiển thị ở đây',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              itemCount: jobs.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final job = jobs[index];
                return GestureDetector(
                  onTap: () => _navigateToJobDetail(context, job),
                  child: Container(
                    padding: EdgeInsets.all(AppDimensions.paddingMD),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusLG,
                      ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.title,
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  AppBadge(
                                    text: _getStatusText(job.status),
                                    type: _getStatusBadgeType(job.status),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy').format(job.createdAt),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        _buildInfoRow(Icons.work, job.category),
                        _buildInfoRow(Icons.location_on, job.address),
                        if (job.price != null)
                          _buildInfoRow(
                            Icons.attach_money,
                            '${job.price!.toStringAsFixed(0)} VNĐ',
                          ),
                        if (job.status == JobStatus.completed &&
                            job.completedAt != null) ...[
                          SizedBox(height: 12.h),
                          Divider(color: AppColors.divider),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hoàn thành: ${DateFormat('dd/MM/yyyy').format(job.completedAt!)}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Rate worker
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_border,
                                      color: AppColors.primary,
                                      size: AppDimensions.iconSM,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      'Đánh giá',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 16.w),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
