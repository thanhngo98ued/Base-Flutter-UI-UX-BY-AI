import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_avatar.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/presentation/pages/worker_detail/bloc/bloc.dart';
import 'package:base/presentation/pages/worker_detail/widgets/hire_worker_bottom_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Worker Detail Screen - Chi tiết thông tin thợ
class WorkerDetailScreen extends StatelessWidget {
  const WorkerDetailScreen({super.key});

  void _showHireBottomSheet(BuildContext context) {
    final worker = context.read<WorkerDetailBloc>().state.worker;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusMD),
        ),
      ),
      builder: (context) => HireWorkerBottomSheet(worker: worker),
    ).then((result) {
      if (result != null) {
        final data = result as Map;
        context.read<WorkerDetailBloc>().add(
          WorkerDetailHireClicked(proposedPrice: data['price']),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerDetailBloc, WorkerDetailState>(
      builder: (context, state) {
        final worker = state.worker;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              // App Bar với Avatar
              SliverAppBar(
                expandedHeight: 200.h,
                pinned: true,
                backgroundColor: AppColors.backgroundLight,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  onPressed: () => context.pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.secondary.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.h),
                          AppAvatar(
                            imageUrl: worker.avatar,
                            name: worker.name,
                            size: 100.w,
                            showOnlineBadge: true,
                            isOnline: worker.isOnline!,
                          ),
                          SizedBox(height: 12.h),
                          Text(worker.name, style: AppTextStyles.h2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingLG),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats row
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.star,
                              value: worker.rating!.toString(),
                              label: 'Đánh giá',
                              color: AppColors.rating,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.work,
                              value: worker.jobsCompleted.toString(),
                              label: 'Công việc',
                              color: AppColors.success,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.navigation,
                              value: '${worker.distance}km',
                              label: 'Khoảng cách',
                              color: AppColors.info,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      // Contact buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                context.read<WorkerDetailBloc>().add(
                                  const WorkerDetailCallClicked(),
                                );
                              },
                              icon: const Icon(Icons.call),
                              label: const Text('Gọi'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.success,
                                side: BorderSide(color: AppColors.success),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                context.read<WorkerDetailBloc>().add(
                                  const WorkerDetailChatClicked(),
                                );
                              },
                              icon: const Icon(Icons.chat),
                              label: const Text('Nhắn tin'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.secondary,
                                side: BorderSide(color: AppColors.secondary),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      // Thông tin cơ bản
                      _buildSection(
                        title: 'Thông tin cơ bản',
                        child: Column(
                          children: [
                            _buildInfoRow(
                              icon: Icons.phone,
                              label: 'Số điện thoại',
                              value: worker.phone,
                            ),
                            Divider(height: 12.h, color: AppColors.divider),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Kỹ năng
                      _buildSection(
                        title: 'Kỹ năng & Dịch vụ',
                        child: Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: worker.skills!
                              .map(
                                (skill) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusRound,
                                    ),
                                    border: Border.all(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  child: Text(
                                    skill,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Reviews (mock)
                      _buildSection(
                        title: 'Đánh giá',
                        child: Column(
                          children: [
                            _buildReviewItem(
                              name: 'Nguyễn Văn A',
                              rating: 5.0,
                              comment:
                                  'Thợ làm việc rất chuyên nghiệp, nhanh chóng',
                              time: '2 ngày trước',
                            ),
                            SizedBox(height: 16.h),
                            _buildReviewItem(
                              name: 'Trần Thị B',
                              rating: 4.8,
                              comment: 'Giá cả hợp lý, làm việc tốt',
                              time: '1 tuần trước',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100.h), // Space for bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Bottom hire button
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(AppDimensions.paddingLG),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: AppButton(
                text: 'Thuê thợ',
                onPressed: () => _showHireBottomSheet(context),
                isLoading: state.status == WorkerDetailStatus.loading,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
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
        children: [
          Icon(icon, color: color, size: 28.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
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
          Text(title, style: AppTextStyles.h3),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem({
    required String name,
    required double rating,
    required String comment,
    required String time,
  }) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.rating, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    rating.toString(),
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            comment,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(time, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
